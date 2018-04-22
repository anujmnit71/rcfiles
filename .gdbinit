set auto-load safe-path /
python
import sys
sys.path.insert(0,'E:/anuj_hd_data/software/mingw-w64/x86_64/mingw64/share/gcc-6.3.0/python')
print "hello world anuj"    
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers (None)
end

