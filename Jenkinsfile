@Library( 'JenkinsPipelineScripts@v15.7.0' ) _

import com.microblink.jenkins.conan.*
import com.microblink.jenkins.environment.*

def params = new BuildParameters()
params.copyrightIgnorePaths = [ 'core/**', 'example/**', 'test/**' ]
params.setEmscriptenEnabled( false )

// we need this library only on Linux and Mac (for development of BR Linux App)
params.conanBuildInfo.disableAll()
params.conanBuildInfo.buildLinuxClang        = true
params.conanBuildInfo.buildLinuxClangHaswell = true
params.conanBuildInfo.buildLinuxClangAarch64 = true
params.conanBuildInfo.buildMacOS             = true

// treat v1.2.0-br branch as stable from Jenkins perspective (branch from which packages are being built)
ConanBranchInfo cbi = new ConanBranchInfo()

cbi.packageChannel = 'stable'
cbi.buildAlways = true

params.branchInfo = [
    'v1.2.0-br': cbi
]

commonConanBuild.buildCoreProjectWithNoTests( params )
