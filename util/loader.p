/* loader.p
 *
 * monitor the staging directory; when files appear select the largest and
 *  - move it to the load directory
 *  - launch a _proutil to load it
 *  - when the load finishes move it to archive directory 
 * rinse and repeat
 *
 * pro -p util/loader.p
 *
 *
 */

define variable testMode as logical no-undo initial false.

define temp-table tt_fileList no-undo
  field fileSize as decimal
  field fileName as character
  field baseName as character format "x(40)"
  field sizeGB   as decimal   format ">>>9.9999" label "GB"
  index fileSize-idx is primary fileSize descending
  index fileName-idx is unique fileName
.

define variable numTbls      as integer   no-undo initial 763.
define variable dumpComplete as integer   no-undo initial 3.

define variable targetDB   as character no-undo format "x(60)".
define variable dlDir      as character no-undo format "x(60)".

define variable stageDir   as character no-undo format "x(60)".
define variable loadDir    as character no-undo format "x(60)".
define variable arcDir     as character no-undo format "x(60)".
define variable logDir     as character no-undo format "x(60)".

define variable osFileName as character no-undo.
define variable cmd        as character no-undo format "x(65)".
define variable xcmd       as character no-undo format "x(60)".
define variable xstatus    as character no-undo format "x(12)"      label "Status".
define variable t          as integer   no-undo format ">>,>>9"     label "Tables Loaded".
define variable w          as integer   no-undo format ">>,>>9"     label "      Waiting".
define variable z          as integer   no-undo format ">>,>>9"     label "       Queued".
define variable n          as integer   no-undo.
define variable gb         as decimal   no-undo format ">>>,>>9.99" label "    GB Loaded".
define variable dt         as character no-undo format "x(8)"       label "Start".
define variable x          as character no-undo format "x(8)"       label "Run Time".
define variable r          as decimal   no-undo format ">>9.9999"   label "GB/sec".
define variable dirSep     as character no-undo.

define stream logFile.

form
  t gb skip
  w z skip
 with
  frame showSummary
  no-box
  row 1
  side-labels
.

form
  dt tt_fileList.sizeGB tt_fileList.baseName xstatus x r skip
 with
  frame showWork
  no-box
  row 4
  down
.

procedure binaryLoad:

  define input parameter stageFile as character no-undo.

  define variable tblName  as character no-undo.
  define variable loadFile as character no-undo.
  define variable arcFile  as character no-undo.
  define variable logFile  as character no-undo.

  define variable startDT  as datetime  no-undo.

  define variable n as integer no-undo.

  n = num-entries( stageFile, "." ).

  assign
    loadFile = replace( stageFile, stageDir, loadDir )
    arcFile  = replace( stageFile, stageDir, arcDir )
    logFile  = replace( replace( stageFile, stageDir, logDir ), ".bd", ".load.log" )
    cmd      = substitute( "_proutil &1 -C load &2 -r >> &3 2>&&1", targetDB, loadFile, logFile )
    xcmd     = entry( 1, cmd, ">" )
    startDT  = now
  .

  xstatus = "launch".
  display substring( string( now ), 12, 8 ) @ dt tt_fileList.sizeGB tt_fileList.baseName xstatus with frame showWork.

  os-rename value( stageFile ) value( loadFile ).

  file-info:file-name = loadFile.
  if file-info:full-pathname = ? then
    do:

      xstatus = "mv failed!".
      display xstatus with frame showWork.
      down with frame showWork.

    end.
   else
    do:

      output stream logFile to value( logFile ).
      put stream logFile unformatted now " " cmd skip.
      output stream logFile close.

      xstatus = "loading...".
      display substring( string( now ), 12, 8 ) @ dt tt_fileList.sizeGB tt_fileList.baseName xstatus with frame showWork.

      if testMode = false then
        do:
          os-command silent value( cmd ).
        end.

      assign
        gb = gb + tt_fileList.sizeGB
        t  = t + 1   /*** ( if entry( n, stageFile, "." ) = ".bd" then 1 else 0 ) ***/
        r  = interval( now, startDT, "seconds" )
        x  = string( integer( r ), "hh:mm:ss" )
        r  = tt_fileList.sizeGB / r
        xstatus = "complete"
      no-error.

      display t gb with frame showSummary.

      display xstatus x r with frame showWork.
      down 1 with frame showWork.

      output stream logFile to value( logFile ) append.
      put stream logFile unformatted now " -- run time: " x " -- " r "  GB/sec" skip.
      output stream logFile close.

      os-rename value( loadFile )  value( arcFile ).

    end.

  return.

end.

/* main block
 *
 */

dirSep = ( if opsys = "unix" then "/" else "~\" ).

assign
  stageDir = os-getenv( "STGDIR" )
  loadDir  = os-getenv( "LOADDIR" )
  arcDir   = os-getenv( "ARCDIR" )
  logDir   = os-getenv( "DL_LGDIR" )
  targetDB = os-getenv( "TGTDIR" ) + dirSep + os-getenv( "DB" )
.

update
  skip(1)
  "       Stage:" stageDir skip
  "        Load:"  loadDir skip
  "     Archive:"   arcDir skip
  "        Logs:"   logDir skip
  skip(1)
  "  Target  DB:" targetDb skip
  skip(1)
  "    # Tables:" numTbls  skip
  skip(1)
 with
  frame updPaths
  no-labels
.

pause 0 before-hide.

watcher: do while lastkey <> 4 and lastkey <> asc( 'q' ) and dumpComplete > 0:		/* and t < numTbls */ 

  empty temp-table tt_fileList.

  input from os-dir( stageDir ).

  dirLoop: repeat:

    import ^ osFileName.

    if osFileName begins "." then next dirLoop.						/* skip hidden files			*/

    n = num-entries( osFileName, "." ).

/*  if r-index( osFileName, ".bd" ) <> ( length( osFileName ) - 2 ) then next dirLoop. */ /* only process binary dump files 	*/

    if not ( entry( n, osFileName, "." ) begins "bd" ) then next dirLoop.		/* only process binary dump files 	*/

/*
    if not ( entry( n, osFileName, "." ) = "bd" ) then					/* numbered .bd file from multi-	*/
      do:										/* threaded dump			*/
      end.										/* currently unsupported		*/
 */

    file-info:file-name = osFileName.

    if file-info:full-pathname <> ? then
      do:
        create tt_fileList.
        assign
          tt_fileList.fileSize = file-info:file-size
          tt_fileList.fileName = file-info:full-pathname
          n = num-entries( file-info:full-pathname, dirSep )
          tt_fileList.baseName = entry( n, file-info:full-pathname, dirSep )
          tt_fileList.sizeGB   = file-info:file-size / ( 1024 * 1024 * 1024 )
        .
      end.

  end.  /* dirLoop */

  w = 0.
  for each tt_filelist:
    w = w + 1.
  end.

  z = numTbls - t.
  display w z with frame showSummary.

  find first tt_fileList no-error.
  loadLoop: do while available tt_fileList and lastkey <> 4 and lastkey <> asc( 'q' ):

    if available tt_fileList then run binaryLoad( tt_fileList.fileName ).

    z = numTbls - t.
    w = w - 1.
    display w z with frame showSummary.

    find next tt_fileList no-error.							/* if there was more than one file	*/

    readkey pause 0.

  end.

  xstatus = "waiting...".
  display xstatus with frame showWork.

  readkey pause 0.1.

  file-info:file-name = logdir + "/dump.complete".
  if file-info:full-pathname <> ? then dumpComplete = dumpComplete - 1.

end. /* watcher */

quit.
