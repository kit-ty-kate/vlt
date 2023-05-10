Instrument with vlt.ppx:
  $ dune describe pp --instrument-with vlt.ppx simple.ml
  [@@@ocaml.ppx.context
    {
      tool_name = "ppx_driver";
      include_dirs = [];
      load_path = [];
      open_modules = [];
      for_package = None;
      debug = false;
      use_threads = false;
      use_vmthreads = false;
      recursive_types = false;
      principal = false;
      transparent_modules = false;
      unboxed_types = false;
      unsafe_string = false;
      cookies = []
    }]
  let () = Vlt.Logger.prepare "Simple"
  let main () =
    Vlt.Logger.logf "Simple.main" Vlt.Level.TRACE ~file:"simple.ml" ~line:4
      ~column:2 ~properties:[] ~error:None "entering main";
    if (Array.length Sys.argv) = 0
    then
      (if Vlt.Logger.check_level "Simple.main" Vlt.Level.WARN
       then
         Vlt.Logger.logf "Simple.main" Vlt.Level.WARN ~file:"simple.ml" ~line:6
           ~column:4 ~properties:[] ~error:None "no %s" "argument"
       else ());
    for i = 1 to pred (Array.length Sys.argv) do
      (try
         if Vlt.Logger.check_level "Simple.main" Vlt.Level.DEBUG
         then
           Vlt.Logger.logf "Simple.main" Vlt.Level.DEBUG ~file:"simple.ml"
             ~line:9 ~column:6 ~properties:[] ~error:None "getting variable "
         else ();
         print_endline (Sys.getenv (Sys.argv.(i)))
       with
       | Not_found ->
           if Vlt.Logger.check_level "Simple.main" Vlt.Level.ERROR
           then
             Vlt.Logger.logf "Simple.main" Vlt.Level.ERROR ~file:"simple.ml"
               ~line:13 ~column:8
               ~properties:(let open Vlt in [("var", (Sys.argv.(i)))])
               ~error:None "undefined variable"
           else ())
    done;
    Vlt.Logger.logf "Simple.main" Vlt.Level.TRACE ~file:"simple.ml" ~line:15
      ~column:2 ~properties:[] ~error:None "leaving main"
  let () =
    if Vlt.Logger.check_level "App" Vlt.Level.INFO
    then
      Vlt.Logger.logf "App" Vlt.Level.INFO ~file:"simple.ml" ~line:18 ~column:2
        ~properties:[] ~error:None "start ..."
    else ();
    (try main ()
     with
     | e ->
         (if Vlt.Logger.check_level "Simple" Vlt.Level.FATAL
          then
            Vlt.Logger.logf "Simple" Vlt.Level.FATAL ~file:"simple.ml" ~line:22
              ~column:4 ~properties:[] ~error:(Some e) "uncaught exception"
          else ();
          Printexc.print_backtrace stdout));
    if Vlt.Logger.check_level "App" Vlt.Level.INFO
    then
      Vlt.Logger.logf "App" Vlt.Level.INFO ~file:"simple.ml" ~line:24 ~column:2
        ~properties:[] ~error:None "end ..."
    else ()
