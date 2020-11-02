lltm_cpp.so : lltm.cpp
	g++ lltm.cpp -o lltm_cpp.so -shared -fPIC -O2 -std=c++14 \
	-D_GLIBCXX_USE_CXX11_ABI=0 \
	-I/usr/include/python3.6m \
	-I/usr/local/lib64/python3.6/site-packages/torch/include \
	-I/usr/local/lib64/python3.6/site-packages/torch/include/torch/csrc/api/include \
	-I/usr/local/lib64/python3.6/site-packages/torch/include/TH \
	-I/usr/local/lib64/python3.6/site-packages/torch/include/THC \
	-L/usr/local/lib64/python3.6/site-packages/torch/lib -lc10 -ltorch -ltorch_cpu -ltorch_python

clean :
	rm lltm_cpp.so