# How to use g++ to compile pytorch extension
In this example, we will use the code from the official example `lltm.cpp`: https://github.com/pytorch/extension-cpp

Use following python commands to get the relevant configurations:

```bash
$ python3
>>> from distutils.sysconfig import get_python_inc
>>> get_python_inc()
/usr/include/python3.6m
>>> from torch.utils.cpp_extension import CppExtension as ext
>>> e = ext('', [])
>>> e.include_dirs
>>> ['/usr/local/lib64/python3.6/site-packages/torch/include', '/usr/local/lib64/python3.6/site-packages/torch/include/torch/csrc/api/include', '/usr/local/lib64/python3.6/site-packages/torch/include/TH', '/usr/local/lib64/python3.6/site-packages/torch/include/THC']
>>> e.library_dirs
['/usr/local/lib64/python3.6/site-packages/torch/lib']
>>> e.libraries
['c10', 'torch', 'torch_cpu', 'torch_python']
```

And combine them together, we will have:

```makefile
lltm_cpp.so : lltm.cpp
	g++ lltm.cpp -o lltm_cpp.so -shared -fPIC -O2 -std=c++14 \
	-D_GLIBCXX_USE_CXX11_ABI=0 \
	-I/usr/include/python3.6m \
	-I/usr/local/lib64/python3.6/site-packages/torch/include \
	-I/usr/local/lib64/python3.6/site-packages/torch/include/torch/csrc/api/include \
	-I/usr/local/lib64/python3.6/site-packages/torch/include/TH \
	-I/usr/local/lib64/python3.6/site-packages/torch/include/THC \
	-L/usr/local/lib64/python3.6/site-packages/torch/lib -lc10 -ltorch -ltorch_cpu -ltorch_python
```

Remember we need to rename the module name defined in `lltm.cpp` to be the same as that of the compiled dynamic library.

```c++
PYBIND11_MODULE(lltm_cpp, m) {
  m.def("forward", &lltm_forward, "LLTM forward");
  m.def("backward", &lltm_backward, "LLTM backward");
}
```

To test the compiled library, run:
```python
$ python3 main.py
Forward: 185.013/223.041 us | Backward 682.592/833.082 us
```
