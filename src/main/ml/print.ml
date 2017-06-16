module MapOfStrings = Map.Make(String)

let rec repeat c n =
      if n > 1 then c ^ (repeat c (n - 1))
      else c
;;

let leftPad s n c = (repeat c (n - (String.length s))) ^ s;;

let rightPad s n c = s ^ (repeat c (n - (String.length s)));;

let print_values language lines =
    print_string("| " ^ (rightPad language 20 " ") ^ " | " ^ (leftPad (string_of_int lines) 20 " ") ^ " |\n");;

let print_as_table lines_by_extension =
    print_string("+-" ^ (repeat "-" 20) ^ "-+-" ^ (repeat "-" 20) ^ "-+\n");
    MapOfStrings.iter print_values lines_by_extension;
    print_string("+-" ^ (repeat "-" 20) ^ "-+-" ^ (repeat "-" 20) ^ "-+\n");
;;