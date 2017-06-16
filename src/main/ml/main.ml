open Dir ;;

module MapOfStrings = Map.Make(String)

let processFileForMap acc v =
  let ext = Dir.get_extension v in
  let linesInThisFile = Dir.count_file_lines v in
  if MapOfStrings.mem ext acc 
  then MapOfStrings.add ext (linesInThisFile + (MapOfStrings.find ext acc)) acc
  else MapOfStrings.add ext linesInThisFile acc
;;

let linesByExtension =
  let filenames = Dir.dir_contents "/w/xl-agatha/client-app" in
    List.fold_left processFileForMap MapOfStrings.empty filenames
;;

let rec repeat c n = 
  if n > 1 then c ^ (repeat c (n - 1)) else c
;;
let leftPad s n c = (repeat c (n - (String.length s))) ^ s;;
let rightPad s n c = s ^ (repeat c (n - (String.length s)));;

let print_values language lines =
    print_string("| " ^ (rightPad language 20 " ") ^ " | " ^ (leftPad (string_of_int lines) 20 " ") ^ " |\n");;

print_string("+-" ^ (repeat "-" 20) ^ "-+-" ^ (repeat "-" 20) ^ "-+\n");;
MapOfStrings.iter print_values linesByExtension;;
print_string("+-" ^ (repeat "-" 20) ^ "-+-" ^ (repeat "-" 20) ^ "-+\n");;

