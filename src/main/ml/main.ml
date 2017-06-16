open Dir ;;
open Print ;;

module MapOfStrings = Map.Make(String)

let processFileForMap acc v =
  let ext = Dir.get_extension v in
  let linesInThisFile = Dir.count_file_lines v in
  if MapOfStrings.mem ext acc 
  then MapOfStrings.add ext (linesInThisFile + (MapOfStrings.find ext acc)) acc
  else MapOfStrings.add ext linesInThisFile acc
;;

let linesByExtension =
  let filenames = Dir.dir_contents "/Users/bogdannechyporenko/proj/xld-ci-explorer" in
    List.fold_left processFileForMap MapOfStrings.empty filenames
;;

Print.print_as_table linesByExtension;;

