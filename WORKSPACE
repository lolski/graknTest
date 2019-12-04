workspace(name = "grakn_test")

################################
# Load Grakn Labs dependencies #
################################

load("//dependencies/maven:dependencies.bzl", "maven_dependencies")
maven_dependencies()

load("//dependencies/graknlabs:dependencies.bzl", "graknlabs_build_tools")
graknlabs_build_tools()

load("@graknlabs_build_tools//distribution:dependencies.bzl", "graknlabs_bazel_distribution")
graknlabs_bazel_distribution()

load("@graknlabs_build_tools//unused_deps:dependencies.bzl", "unused_deps_dependencies")
unused_deps_dependencies()

###########################
# Load Bazel dependencies #
###########################

load("@graknlabs_build_tools//bazel:dependencies.bzl", "bazel_common", "bazel_deps", "bazel_toolchain")
bazel_common()
bazel_deps()
bazel_toolchain()


#################################
# Load Build Tools dependencies #
#################################

load("@graknlabs_build_tools//checkstyle:dependencies.bzl", "checkstyle_dependencies")
checkstyle_dependencies()

load("@graknlabs_build_tools//sonarcloud:dependencies.bzl", "sonarcloud_dependencies")
sonarcloud_dependencies()

#load("@graknlabs_build_tools//bazel:dependencies.bzl", "bazel_rules_python")
#bazel_rules_python()
#
#load("@io_bazel_rules_python//python:pip.bzl", "pip_repositories", "pip_import")
#pip_repositories()
#
#pip_import(
#    name = "graknlabs_build_tools_ci_pip",
#    requirements = "@graknlabs_build_tools//ci:requirements.txt",
#)
#
#load("@graknlabs_build_tools_ci_pip//:requirements.bzl",
#graknlabs_build_tools_ci_pip_install = "pip_install")
#graknlabs_build_tools_ci_pip_install()


#####################################
# Load Java dependencies from Maven #
#####################################

# load("//dependencies/maven:dependencies.bzl", "maven_dependencies")
# maven_dependencies()


##################################
# Load Distribution dependencies #
##################################

load("@graknlabs_bazel_distribution//github:dependencies.bzl", "tcnksm_ghr")
tcnksm_ghr()

load("@graknlabs_bazel_distribution//common:dependencies.bzl", "bazelbuild_rules_pkg")
bazelbuild_rules_pkg()


#####################################
# Load Bazel common workspace rules #
#####################################

# TODO: Figure out why this cannot be loaded at earlier at the top of the file
load("@com_github_google_bazel_common//:workspace_defs.bzl", "google_common_workspace_rules")
google_common_workspace_rules()

# Generate a JSON document of commit hashes of all external workspace dependencies
load("@graknlabs_bazel_distribution//common:rules.bzl", "workspace_refs")
workspace_refs(
    name = "graknlabs_common_workspace_refs"
)