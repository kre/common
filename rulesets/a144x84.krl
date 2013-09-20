ruleset a144x84 {
  meta {
    name "defAction"
    description <<
      For testing composable actions in modules
      System tests depend on this ruleset.  
    >>
 
   configure using c = "Hello"
   provide x, cpost
  
  }
 
  dispatch {
  }
 
  global {
     a = function(x) {5 + x + 0};
     x = defaction (y) {
       configure using w = "FOO" and blue = "fiddyfiddyfappap"
        farb = y + blue;
        every {
         noop();
         alert(farb);
        }
     };
     cpost = defaction (blob) {
      stink="yes";
      {
        http:post("http://www.postbin.org/1ie2llx") with params = {"msg":"hello", "rnd":blob};
      }
    };
  } 
}
