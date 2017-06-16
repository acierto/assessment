open Str;;
open String ;;

let matched what where =
  Str.string_match (Str.regexp(".*" ^ what ^ ".*")) where 0
;;

let dir_contents dir =
  let rec loop result = function
    | f::fs when Sys.is_directory f ->
      Sys.readdir f
      |> Array.to_list
      |> List.map (Filename.concat f)
      |> List.filter (fun fileName -> not(matched "\\/node_modules\\/" fileName))
      |> List.filter (fun fileName -> not(matched "\\/.git\\/" fileName))
      |> List.filter (fun fileName -> not(matched "\\/.gradle\\/" fileName))
      |> List.filter (fun fileName -> not(matched "\\/.idea\\/" fileName))
      |> List.filter (fun fileName -> not(matched "\\/build\\/" fileName))
      |> List.filter (fun fileName -> not(matched "\\/buildSrc\\/" fileName))
      |> List.append fs
      |> loop result
    | f::fs -> loop (f::result) fs
    | []    -> result
  in
  loop [] [dir]
;;

let read_line i = try Some (input_line i) with End_of_file -> None

let lines_from_files filename =
  let rec lines_from_files_aux i acc = match (read_line i) with
      | None -> List.rev acc
      | Some s -> lines_from_files_aux i (s :: acc) in
  lines_from_files_aux (open_in filename) []
;;

let count_file_lines filename =
  List.length (lines_from_files filename)
;;

let get_extension file_name =
    let dotIndex = (String.rindex file_name '.') in
        let file_name_length = (String.length file_name) in
            String.sub file_name (dotIndex + 1) (file_name_length - dotIndex - 1)
;;