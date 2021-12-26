from conans import ConanFile, tools, CMake
from conans.errors import ConanInvalidConfiguration
import os
class ZXingCppConan(ConanFile):
    name = "zxing-cpp-br"
    version = "1.2.0"
    homepage = "https://github.com/BlinkReceipt/zxing-cpp"
    description = "c++14 port of ZXing, a barcode scanning library"
    topics = ("conan", "zxing", "barcode", "scanner", "generator")
    url = "https://github.com/conan-io/conan-center-index"
    license = "Apache-2.0"
    exports_sources = ["CMakeLists.txt", "core/**", "example/**","test/**","thirdparty/**","wrappers/**","zxing.pc.in"]
    settings = "os", "arch", "compiler", "build_type"
    options = {
        "shared": [True, False],
        "fPIC": [True, False],
        "enable_encoders": [True, False],
        "enable_decoders": [True, False],
    }
    default_options = {
        "shared": False,
        "fPIC": True,
        "enable_encoders": True,
        "enable_decoders": True,
    }
    generators = "cmake"
    _cmake = None
    _source_subfolder = "source_subfolder"
    _build_subfolder = "build_subfolder"
    _compiler_cpp14_support = {
        "gcc": "5",
        "Visual Studio": "14",
        "clang": "3.4",
        "apple-clang": "3.4",
    }
    def config_options(self):
        if self.settings.os == "Windows":
            del self.options.fPIC
        if self.settings.compiler.cppstd:
            tools.check_min_cppstd(self, 14)
        try:
            minimum_required_version = self._compiler_cpp14_support[str(self.settings.compiler)]
            if self.settings.compiler.version < tools.Version(minimum_required_version):
                raise ConanInvalidConfiguration("This compiler is too old. This library needs a compiler with c++14 support")
        except KeyError:
            self.output.warn("This recipe might not support the compiler. Consider adding it.")
    def configure(self):
        if self.options.shared:
            del self.options.fPIC
    def _configure_cmake(self):
        if self._cmake:
            return self._cmake
        self._cmake = CMake(self)
        self._cmake.definitions["ENABLE_ENCODERS"] = self.options.enable_encoders
        self._cmake.definitions["ENABLE_DECODERS"] = self.options.enable_decoders
        self._cmake.configure(build_folder=self._build_subfolder)
        return self._cmake
    def build(self):
        cmake = self._configure_cmake()
        cmake.build()
    def package(self):
        self.copy(pattern="LICENSE*", src=self._source_subfolder, dst="licenses")
        cmake = self._configure_cmake()
        cmake.install()
        tools.rmdir(os.path.join(self.package_folder, "lib", "cmake"))
        tools.rmdir(os.path.join(self.package_folder, "lib", "pkgconfig"))
    def package_info(self):
        self.cpp_info.names["cmake_find_package"] = "ZXing"
        self.cpp_info.names["cmake_find_package_multi"] = "ZXing"
        self.cpp_info.names["pkg_config"] = "zxing"
        self.cpp_info.libs = ["ZXing"]
        if self.settings.os == "Linux":
            self.cpp_info.system_libs = ["pthread", "m"]
