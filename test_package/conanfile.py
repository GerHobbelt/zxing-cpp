from conans import tools, ConanFile
import os
import shutil


class ZXingPackageTest(ConanFile):

    python_requires = 'MicroblinkConanFile/8.1.0@microblink/stable'
    python_requires_extend = 'MicroblinkConanFile.MicroblinkConanFile'

    requires = (
        'CMakeBuild/17.6.3@microblink/stable',
        'CoreUtils/9.2.3@microblink/stable',  # for image load support
    )

    def test(self):
        if tools.cross_building(self.settings) and self.settings.os != 'Macos':
            return
        os.chdir("bin")
        shutil.copyfile(os.path.join(self.source_folder, 'test-qr.jpg'), 'test-qr.jpg')
        with tools.environment_append({'ASAN_OPTIONS': 'detect_container_overflow=0'}):
            self.run(
                ".{}ZXingTest{} test-qr.jpg".format(os.sep, ".exe" if self.settings.os == "Windows" else ""),
                run_environment=True
            )
