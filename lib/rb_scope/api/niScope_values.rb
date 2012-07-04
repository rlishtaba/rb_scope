module RbScope

  # This module reads the file rb_scope/niScope_pairs 
  # and use the information inside to automatically generate constants
  # with values equivalent to the niScope.h #define macro constants.
  # The file rb_scope/niScope_pairs is automatically generated by the 
  # shell script extract_all.sh in ext/rb_scope/generators
  module API

    module Values

      Hash.new.tap{ |pairs|   
        File.open(File.dirname(__FILE__) + '/niScope_pairs.const', 'r').readlines.tap do |lines|
          pairs[lines.shift] = lines.shift until lines.empty? #good 2 shift order
        end     
      }.each do |k,v|
        begin
          self.const_set k.chomp, eval(v)     #don't forget to chomp the line
        rescue Exception => e
          #puts "eval error for value %s" % k
        end    
      end
      
      #for safety, redefine these
      VI_SUCCESS  = 0
      VI_NULL     = 0
      VI_TRUE     = 1
      VI_FALSE    = 0
      
    end
  
  end

end