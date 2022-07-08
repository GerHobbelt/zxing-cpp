from conans import ConanFile


class ZXingCppConan(ConanFile):
    name = "zxing-cpp-br"
    version = "1.2.0"
    homepage = "https://github.com/BlinkReceipt/zxing-cpp"
    description = "c++14 port of ZXing, a barcode scanning library"
    url = "https://github.com/BlinkReceipt/zxing-cpp"
    license = "Apache-2.0"
    scm = {
        "type": "git",
        "url": "auto",
        "revision": "auto"
    }

    python_requires = 'MicroblinkConanFile/8.1.0@microblink/stable'
    python_requires_extend = 'MicroblinkConanFile.MicroblinkConanFile'

    requires = (
        'CMakeBuild/17.6.3@microblink/stable',
    )

    def package(self):
        self.cmake_install()

    def package_info(self):
        self.cpp_info.names["cmake_find_package"] = "ZXing"
        self.cpp_info.names["cmake_find_package_multi"] = "ZXing"
        self.cpp_info.names["pkg_config"] = "zxing"
        self.cpp_info.libs = ["ZXing"]
        if self.settings.os == "Linux":
            self.cpp_info.system_libs = ["pthread", "m"]
