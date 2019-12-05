# Do not edit. bazel-deps autogenerates this file from dependencies/maven/dependencies.yaml.
def _jar_artifact_impl(ctx):
    jar_name = "%s.jar" % ctx.name
    ctx.download(
        output=ctx.path("jar/%s" % jar_name),
        url=ctx.attr.urls,
        sha256=ctx.attr.sha256,
        executable=False
    )
    src_name="%s-sources.jar" % ctx.name
    srcjar_attr=""
    has_sources = len(ctx.attr.src_urls) != 0
    if has_sources:
        ctx.download(
            output=ctx.path("jar/%s" % src_name),
            url=ctx.attr.src_urls,
            sha256=ctx.attr.src_sha256,
            executable=False
        )
        srcjar_attr ='\n    srcjar = ":%s",' % src_name

    build_file_contents = """
package(default_visibility = ['//visibility:public'])
java_import(
    name = 'jar',
    tags = ['maven_coordinates={artifact}'],
    jars = ['{jar_name}'],{srcjar_attr}
)
filegroup(
    name = 'file',
    srcs = [
        '{jar_name}',
        '{src_name}'
    ],
    visibility = ['//visibility:public']
)\n""".format(artifact = ctx.attr.artifact, jar_name = jar_name, src_name = src_name, srcjar_attr = srcjar_attr)
    ctx.file(ctx.path("jar/BUILD"), build_file_contents, False)
    return None

jar_artifact = repository_rule(
    attrs = {
        "artifact": attr.string(mandatory = True),
        "sha256": attr.string(mandatory = True),
        "urls": attr.string_list(mandatory = True),
        "src_sha256": attr.string(mandatory = False, default=""),
        "src_urls": attr.string_list(mandatory = False, default=[]),
    },
    implementation = _jar_artifact_impl
)

def jar_artifact_callback(hash):
    src_urls = []
    src_sha256 = ""
    source=hash.get("source", None)
    if source != None:
        src_urls = [source["url"]]
        src_sha256 = source["sha256"]
    jar_artifact(
        artifact = hash["artifact"],
        name = hash["name"],
        urls = [hash["url"]],
        sha256 = hash["sha256"],
        src_urls = src_urls,
        src_sha256 = src_sha256
    )
    native.bind(name = hash["bind"], actual = hash["actual"])


def list_dependencies():
    return [
    {"artifact": "ch.qos.logback:logback-classic:1.2.3", "lang": "java", "sha1": "7c4f3c474fb2c041d8028740440937705ebb473a", "sha256": "fb53f8539e7fcb8f093a56e138112056ec1dc809ebb020b59d8a36a5ebac37e0", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/ch/qos/logback/logback-classic/1.2.3/logback-classic-1.2.3.jar", "source": {"sha1": "cfd5385e0c5ed1c8a5dce57d86e79cf357153a64", "sha256": "480cb5e99519271c9256716d4be1a27054047435ff72078d9deae5c6a19f63eb", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/ch/qos/logback/logback-classic/1.2.3/logback-classic-1.2.3-sources.jar"} , "name": "ch-qos-logback-logback-classic", "actual": "@ch-qos-logback-logback-classic//jar", "bind": "jar/ch/qos/logback/logback-classic"},
    {"artifact": "ch.qos.logback:logback-core:1.2.3", "lang": "java", "sha1": "864344400c3d4d92dfeb0a305dc87d953677c03c", "sha256": "5946d837fe6f960c02a53eda7a6926ecc3c758bbdd69aa453ee429f858217f22", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/ch/qos/logback/logback-core/1.2.3/logback-core-1.2.3.jar", "source": {"sha1": "3ebabe69eba0196af9ad3a814f723fb720b9101e", "sha256": "1f69b6b638ec551d26b10feeade5a2b77abe347f9759da95022f0da9a63a9971", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/ch/qos/logback/logback-core/1.2.3/logback-core-1.2.3-sources.jar"} , "name": "ch-qos-logback-logback-core", "actual": "@ch-qos-logback-logback-core//jar", "bind": "jar/ch/qos/logback/logback-core"},
    {"artifact": "com.google.api.grpc:proto-google-common-protos:1.0.0", "lang": "java", "sha1": "86f070507e28b930e50d218ee5b6788ef0dd05e6", "sha256": "cfe1da4c0e82820c32a83c4bf25b42f4d3b7113177321c437a9fff3c42e1f4c9", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/api/grpc/proto-google-common-protos/1.0.0/proto-google-common-protos-1.0.0.jar", "source": {"sha1": "b48d52024623007eaf1a5636c28f3699a8a078a5", "sha256": "0d016cc4677bb7bb721ebf862f3cd07e7df9710a677c3412081887c786756d73", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/api/grpc/proto-google-common-protos/1.0.0/proto-google-common-protos-1.0.0-sources.jar"} , "name": "com-google-api-grpc-proto-google-common-protos", "actual": "@com-google-api-grpc-proto-google-common-protos//jar", "bind": "jar/com/google/api/grpc/proto-google-common-protos"},
# duplicates in com.google.code.findbugs:jsr305 promoted to 3.0.2
# - com.google.guava:guava:26.0-android wanted version 3.0.2
# - io.grakn.client:grakn-client:1.6.1 wanted version 2.0.2
# - io.graql:graql-lang:1.0.5 wanted version 2.0.2
# - io.grpc:grpc-core:1.16.0 wanted version 3.0.2
    {"artifact": "com.google.code.findbugs:jsr305:3.0.2", "lang": "java", "sha1": "25ea2e8b0c338a877313bd4672d3fe056ea78f0d", "sha256": "766ad2a0783f2687962c8ad74ceecc38a28b9f72a2d085ee438b7813e928d0c7", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/code/findbugs/jsr305/3.0.2/jsr305-3.0.2.jar", "source": {"sha1": "b19b5927c2c25b6c70f093767041e641ae0b1b35", "sha256": "1c9e85e272d0708c6a591dc74828c71603053b48cc75ae83cce56912a2aa063b", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/code/findbugs/jsr305/3.0.2/jsr305-3.0.2-sources.jar"} , "name": "com-google-code-findbugs-jsr305", "actual": "@com-google-code-findbugs-jsr305//jar", "bind": "jar/com/google/code/findbugs/jsr305"},
    {"artifact": "com.google.code.gson:gson:2.7", "lang": "java", "sha1": "751f548c85fa49f330cecbb1875893f971b33c4e", "sha256": "2d43eb5ea9e133d2ee2405cc14f5ee08951b8361302fdd93494a3a997b508d32", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/code/gson/gson/2.7/gson-2.7.jar", "source": {"sha1": "bbb63ca253b483da8ee53a50374593923e3de2e2", "sha256": "2d3220d5d936f0a26258aa3b358160741a4557e046a001251e5799c2db0f0d74", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/code/gson/gson/2.7/gson-2.7-sources.jar"} , "name": "com-google-code-gson-gson", "actual": "@com-google-code-gson-gson//jar", "bind": "jar/com/google/code/gson/gson"},
# duplicates in com.google.errorprone:error_prone_annotations promoted to 2.2.0
# - com.google.guava:guava:26.0-android wanted version 2.1.3
# - io.grpc:grpc-core:1.16.0 wanted version 2.2.0
# - io.opencensus:opencensus-api:0.12.3 wanted version 2.2.0
# - io.opencensus:opencensus-contrib-grpc-metrics:0.12.3 wanted version 2.2.0
    {"artifact": "com.google.errorprone:error_prone_annotations:2.2.0", "lang": "java", "sha1": "88e3c593e9b3586e1c6177f89267da6fc6986f0c", "sha256": "6ebd22ca1b9d8ec06d41de8d64e0596981d9607b42035f9ed374f9de271a481a", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/errorprone/error_prone_annotations/2.2.0/error_prone_annotations-2.2.0.jar", "source": {"sha1": "a8cd7823aa1dcd2fd6677c0c5988fdde9d1fb0a3", "sha256": "626adccd4894bee72c3f9a0384812240dcc1282fb37a87a3f6cb94924a089496", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/errorprone/error_prone_annotations/2.2.0/error_prone_annotations-2.2.0-sources.jar"} , "name": "com-google-errorprone-error_prone_annotations", "actual": "@com-google-errorprone-error_prone_annotations//jar", "bind": "jar/com/google/errorprone/error-prone-annotations"},
# duplicates in com.google.guava:guava promoted to 26.0-android
# - io.grakn.client:grakn-client:1.6.1 wanted version 23.0
# - io.grakn.protocol:grakn-protocol:1.0.3 wanted version 23.0
# - io.graql:graql-lang:1.0.5 wanted version 23.0
# - io.grpc:grpc-core:1.16.0 wanted version 26.0-android
# - io.grpc:grpc-protobuf-lite:1.16.0 wanted version 26.0-android
# - io.grpc:grpc-protobuf:1.16.0 wanted version 26.0-android
    {"artifact": "com.google.guava:guava:26.0-android", "lang": "java", "sha1": "ef69663836b339db335fde0df06fb3cd84e3742b", "sha256": "1d044ebb866ef08b7d04e998b4260c9b52fab6e6d6b68d207859486bb3686cd5", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/guava/guava/26.0-android/guava-26.0-android.jar", "source": {"sha1": "d77b633b56308a972029983a244f6bb9e24e1924", "sha256": "b15500dd90a848438766421357da0560929973469e588412e146f9eba5e0b316", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/guava/guava/26.0-android/guava-26.0-android-sources.jar"} , "name": "com-google-guava-guava", "actual": "@com-google-guava-guava//jar", "bind": "jar/com/google/guava/guava"},
    {"artifact": "com.google.j2objc:j2objc-annotations:1.1", "lang": "java", "sha1": "ed28ded51a8b1c6b112568def5f4b455e6809019", "sha256": "2994a7eb78f2710bd3d3bfb639b2c94e219cedac0d4d084d516e78c16dddecf6", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/j2objc/j2objc-annotations/1.1/j2objc-annotations-1.1.jar", "source": {"sha1": "1efdf5b737b02f9b72ebdec4f72c37ec411302ff", "sha256": "2cd9022a77151d0b574887635cdfcdf3b78155b602abc89d7f8e62aba55cfb4f", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/j2objc/j2objc-annotations/1.1/j2objc-annotations-1.1-sources.jar"} , "name": "com-google-j2objc-j2objc-annotations", "actual": "@com-google-j2objc-j2objc-annotations//jar", "bind": "jar/com/google/j2objc/j2objc-annotations"},
# duplicates in com.google.protobuf:protobuf-java promoted to 3.5.1
# - io.grakn.protocol:grakn-protocol:1.0.3 wanted version 3.4.0
# - io.grpc:grpc-protobuf:1.16.0 wanted version 3.5.1
    {"artifact": "com.google.protobuf:protobuf-java:3.5.1", "lang": "java", "sha1": "8c3492f7662fa1cbf8ca76a0f5eb1146f7725acd", "sha256": "b5e2d91812d183c9f053ffeebcbcda034d4de6679521940a19064714966c2cd4", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/protobuf/protobuf-java/3.5.1/protobuf-java-3.5.1.jar", "source": {"sha1": "7235a28a13938050e8cd5d9ed5133bebf7a4dca7", "sha256": "3be3115498d543851443bfa725c0c5b28140e363b3b7dec97f4028cd17040fa4", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/protobuf/protobuf-java/3.5.1/protobuf-java-3.5.1-sources.jar"} , "name": "com-google-protobuf-protobuf-java", "actual": "@com-google-protobuf-protobuf-java//jar", "bind": "jar/com/google/protobuf/protobuf-java"},
    {"artifact": "io.grakn.client:grakn-client:1.6.1", "lang": "java", "sha1": "9a116d1a46342c5036c62aa5ba0590eee173f655", "sha256": "c022e99687f7ba50ef1e314dfed741ffec36bf5a3c82bf5c00878ac6b5e4b3d2", "repository": "https://repo.grakn.ai/repository/maven/", "url": "https://repo.grakn.ai/repository/maven/io/grakn/client/grakn-client/1.6.1/grakn-client-1.6.1.jar", "source": {"sha1": "31260f634ef0a5ca0d596549eb4f565c6352f5c9", "sha256": "764f748f6ac406ba32914bf1c90f0eb0ee2ade7f6a581b9fd1058eb44aeb2172", "repository": "https://repo.grakn.ai/repository/maven/", "url": "https://repo.grakn.ai/repository/maven/io/grakn/client/grakn-client/1.6.1/grakn-client-1.6.1-sources.jar"} , "name": "io-grakn-client-grakn-client", "actual": "@io-grakn-client-grakn-client//jar", "bind": "jar/io/grakn/client/grakn-client"},
    {"artifact": "io.grakn.common:grakn-common:0.2.2", "lang": "java", "sha1": "696925e6d050d0fc620c1e9f3965e8158ce2bf9f", "sha256": "9b67a078c5836ee5231f78d0c9b3914fef76710368c29a933cf9bae3c3ccd869", "repository": "https://repo.grakn.ai/repository/maven/", "url": "https://repo.grakn.ai/repository/maven/io/grakn/common/grakn-common/0.2.2/grakn-common-0.2.2.jar", "source": {"sha1": "3b4191b5f3fa8c3f20ada50dfd3a8acd037a0194", "sha256": "eca7c7b8076ea11356c81de07bc2cfd161d62d207ae17eb89cf2c550eb234cf0", "repository": "https://repo.grakn.ai/repository/maven/", "url": "https://repo.grakn.ai/repository/maven/io/grakn/common/grakn-common/0.2.2/grakn-common-0.2.2-sources.jar"} , "name": "io-grakn-common-grakn-common", "actual": "@io-grakn-common-grakn-common//jar", "bind": "jar/io/grakn/common/grakn-common"},
    {"artifact": "io.grakn.protocol:grakn-protocol:1.0.3", "lang": "java", "sha1": "8c5cac5da5001f27f874477df98b5ad9b7f89e23", "sha256": "7b4e1c1f508115e2f33c834b2879b99be8565320161e6ed67daa0862166adaae", "repository": "https://repo.grakn.ai/repository/maven/", "url": "https://repo.grakn.ai/repository/maven/io/grakn/protocol/grakn-protocol/1.0.3/grakn-protocol-1.0.3.jar", "source": {"sha1": "4a695bb51273c445a90013073683b674fc50bfaf", "sha256": "307ea6497e829d7ffed2e72d246f0ff840580d48c11d9c1cd134ad1f56225221", "repository": "https://repo.grakn.ai/repository/maven/", "url": "https://repo.grakn.ai/repository/maven/io/grakn/protocol/grakn-protocol/1.0.3/grakn-protocol-1.0.3-sources.jar"} , "name": "io-grakn-protocol-grakn-protocol", "actual": "@io-grakn-protocol-grakn-protocol//jar", "bind": "jar/io/grakn/protocol/grakn-protocol"},
    {"artifact": "io.graql:graql-grammar:1.0.5", "lang": "java", "sha1": "14a8339b83e78f0783de54306600101f0b9c9cdf", "sha256": "5a359451d3f608530c12d11f03b5b09a24462af8c752061c62e178e6f7df392b", "repository": "https://repo.grakn.ai/repository/maven/", "url": "https://repo.grakn.ai/repository/maven/io/graql/graql-grammar/1.0.5/graql-grammar-1.0.5.jar", "source": {"sha1": "bfe40c30dcb445170de5f43077963a8d6e223b78", "sha256": "af4e977587bb102509749277a9fb9602355ffad6ca4c12ba92c9650e9f499ebd", "repository": "https://repo.grakn.ai/repository/maven/", "url": "https://repo.grakn.ai/repository/maven/io/graql/graql-grammar/1.0.5/graql-grammar-1.0.5-sources.jar"} , "name": "io-graql-graql-grammar", "actual": "@io-graql-graql-grammar//jar", "bind": "jar/io/graql/graql-grammar"},
    {"artifact": "io.graql:graql-lang:1.0.5", "lang": "java", "sha1": "5d3253cbf2bb25657f6eeda88ecb1da8a0c385d4", "sha256": "cf984a299b535c736eae6d427ef07e1eb093c0caf8485df1b3f596698d76a208", "repository": "https://repo.grakn.ai/repository/maven/", "url": "https://repo.grakn.ai/repository/maven/io/graql/graql-lang/1.0.5/graql-lang-1.0.5.jar", "source": {"sha1": "02683f55711b648388ea52a163ebc517952dfb66", "sha256": "87c5b6f0f6cca8c5059c10066a9b701f812c40cfd73edc1535062f8ba75d6525", "repository": "https://repo.grakn.ai/repository/maven/", "url": "https://repo.grakn.ai/repository/maven/io/graql/graql-lang/1.0.5/graql-lang-1.0.5-sources.jar"} , "name": "io-graql-graql-lang", "actual": "@io-graql-graql-lang//jar", "bind": "jar/io/graql/graql-lang"},
    {"artifact": "io.grpc:grpc-context:1.16.0", "lang": "java", "sha1": "c979cb271666193f5ce7e704cbf9328d82eec14c", "sha256": "e6d2df6ccc8274093c8e42c23a9f600fb88f10581e7cd5a027936c64c01ba44b", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-context/1.16.0/grpc-context-1.16.0.jar", "source": {"sha1": "d191e7a7eb9c2ec451d29c2d2a3a1774ab745b54", "sha256": "ca6d28dc2722aa1aac1b8e0cb9d415381104d5ff31f51fc48883252c68f3c291", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-context/1.16.0/grpc-context-1.16.0-sources.jar"} , "name": "io-grpc-grpc-context", "actual": "@io-grpc-grpc-context//jar", "bind": "jar/io/grpc/grpc-context"},
# duplicates in io.grpc:grpc-core promoted to 1.16.0
# - io.grakn.protocol:grakn-protocol:1.0.3 wanted version 1.16.0
# - io.grpc:grpc-netty:1.16.0 wanted version [1.16.0]
# - io.grpc:grpc-protobuf-lite:1.16.0 wanted version 1.16.0
# - io.grpc:grpc-protobuf:1.16.0 wanted version 1.16.0
# - io.grpc:grpc-stub:1.16.0 wanted version 1.16.0
    {"artifact": "io.grpc:grpc-core:1.16.0", "lang": "java", "sha1": "eb2dbfedffb5f2ce9ada9a1577d3e01be0a6cd77", "sha256": "33d6ccd6bb6168e107cffa6bedac1f16939ac65d3f60839568ab96eeb70e0597", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-core/1.16.0/grpc-core-1.16.0.jar", "source": {"sha1": "48b139d706b0dc9e8ce48d9d0b8bd334cb884801", "sha256": "35e2bf94559382b2961f5edae69f1331bfabf37fdde450050ed1430047a8949a", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-core/1.16.0/grpc-core-1.16.0-sources.jar"} , "name": "io-grpc-grpc-core", "actual": "@io-grpc-grpc-core//jar", "bind": "jar/io/grpc/grpc-core"},
    {"artifact": "io.grpc:grpc-netty:1.16.0", "lang": "java", "sha1": "c337307ad07cddd2d1b7ae67a029f6c14929414a", "sha256": "6aaa0b50402933844f1c038b4b84d5e2d196d29f04c77ab933484f5c3e577d5d", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-netty/1.16.0/grpc-netty-1.16.0.jar", "source": {"sha1": "4d57f9166d03e728cadcb72a8d9333c2154d27c5", "sha256": "a2ee330e639668b2c8c92560233a824c0ba75e9af416b19da2c8c77d2ab8b3f6", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-netty/1.16.0/grpc-netty-1.16.0-sources.jar"} , "name": "io-grpc-grpc-netty", "actual": "@io-grpc-grpc-netty//jar", "bind": "jar/io/grpc/grpc-netty"},
    {"artifact": "io.grpc:grpc-protobuf-lite:1.16.0", "lang": "java", "sha1": "77776a41c4408c59e921cc26647736c1567f0807", "sha256": "5a3ecfcef5db15640088b3c71b2ee12aeaef5e27af03fcf6059b2cd935bdcc47", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-protobuf-lite/1.16.0/grpc-protobuf-lite-1.16.0.jar", "source": {"sha1": "ad67bda2c05080b0010020626b3ac94aa49106f6", "sha256": "8066d1eac0bdbffec3eace3ed290aeb25f1b87839f85f6ad1ab799cf02680697", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-protobuf-lite/1.16.0/grpc-protobuf-lite-1.16.0-sources.jar"} , "name": "io-grpc-grpc-protobuf-lite", "actual": "@io-grpc-grpc-protobuf-lite//jar", "bind": "jar/io/grpc/grpc-protobuf-lite"},
    {"artifact": "io.grpc:grpc-protobuf:1.16.0", "lang": "java", "sha1": "a49b55f8fb9ffe26b7464db5db0c0b4d874d5107", "sha256": "7f2995d3e1c3cf7cf6c0afed14f6822f7b641d31099ddd42f15cedc4f1fcb02f", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-protobuf/1.16.0/grpc-protobuf-1.16.0.jar", "source": {"sha1": "ee63b53c0458cc71a2bcc291db8aae8a63afb714", "sha256": "909691a5c7f20e870cb1c4e85510410a195932e7d9b6d7e8e57d88a6c3d2b8f7", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-protobuf/1.16.0/grpc-protobuf-1.16.0-sources.jar"} , "name": "io-grpc-grpc-protobuf", "actual": "@io-grpc-grpc-protobuf//jar", "bind": "jar/io/grpc/grpc-protobuf"},
    {"artifact": "io.grpc:grpc-stub:1.16.0", "lang": "java", "sha1": "5dd67cad593ccd7cce3f76c9cdd2c2afa259c7bb", "sha256": "c1a6bdae606c11810ff2d452d2c37d7334b4aa283a126b2ea6a62527382a4dbe", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-stub/1.16.0/grpc-stub-1.16.0.jar", "source": {"sha1": "42d2f5ed27e06bfcc258cb92646d4dadd638ea5f", "sha256": "5fc735b9ae273b2b84ce7039f45b87011d54d42553a8721f6fc3af8bc806b312", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-stub/1.16.0/grpc-stub-1.16.0-sources.jar"} , "name": "io-grpc-grpc-stub", "actual": "@io-grpc-grpc-stub//jar", "bind": "jar/io/grpc/grpc-stub"},
    {"artifact": "io.netty:netty-all:4.1.39.Final", "lang": "java", "sha1": "8de94e67d766103ac211e42f6cd9bb4b32e33e60", "sha256": "2f9636f9192d1572d4c734aced3511e0794d79749c6144a9ebdda1c7bb1de74f", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-all/4.1.39.Final/netty-all-4.1.39.Final.jar", "source": {"sha1": "4d82e28a78ab350ce06611c06cbfe07ed6f1825f", "sha256": "d4dfd3ef9cfd4433c360cbccce00c30c4dce5386023aa592c01939498e64446d", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-all/4.1.39.Final/netty-all-4.1.39.Final-sources.jar"} , "name": "io-netty-netty-all", "actual": "@io-netty-netty-all//jar", "bind": "jar/io/netty/netty-all"},
    {"artifact": "io.netty:netty-buffer:4.1.30.Final", "lang": "java", "sha1": "597adb653306470fb3ec1af3c0f3f30a37b1310a", "sha256": "dac32e67876f416e0526c457bbb4d4a7b245d2d6977a39e3ed54484370d86d6e", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-buffer/4.1.30.Final/netty-buffer-4.1.30.Final.jar", "source": {"sha1": "e7e5789c789b4f3e6069ee2ed9e5e102c7868ad8", "sha256": "16354a73bf34e4c64bb703f3b6c5dbd2c8b47a1c4a130f0e2ff25f7153d8b852", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-buffer/4.1.30.Final/netty-buffer-4.1.30.Final-sources.jar"} , "name": "io-netty-netty-buffer", "actual": "@io-netty-netty-buffer//jar", "bind": "jar/io/netty/netty-buffer"},
    {"artifact": "io.netty:netty-codec-http2:[4.1.30.Final]", "lang": "java", "sha1": "2da92f518409904954d3e8dcc42eb6a562a70302", "sha256": "8636be7896f88e4d1a363875d53c8521a90913915854a3cfed0486024ba4a07f", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-codec-http2/4.1.30.Final/netty-codec-http2-4.1.30.Final.jar", "source": {"sha1": "4028134a4c155c6f83972912b9b5370a4b0a656a", "sha256": "ef3f6fe0cd4251fd5adb81bb183bf079585104b44ac42d1423db32c545ea2a41", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-codec-http2/4.1.30.Final/netty-codec-http2-4.1.30.Final-sources.jar"} , "name": "io-netty-netty-codec-http2", "actual": "@io-netty-netty-codec-http2//jar", "bind": "jar/io/netty/netty-codec-http2"},
    {"artifact": "io.netty:netty-codec-http:4.1.30.Final", "lang": "java", "sha1": "1384c630e8a0eeef33ad12a28791dce6e1d8767c", "sha256": "0beb4874977de5cb2b4f1e5b4f986050208c49bf485c093ae6e3681b9eba8d6c", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-codec-http/4.1.30.Final/netty-codec-http-4.1.30.Final.jar", "source": {"sha1": "218b33bae3a4e5cebe489ff65647e9ec9de58ef1", "sha256": "08e40605e479214f5aace6405912cd31bb337669f5f0cd70e8cd3bbadd5a8eca", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-codec-http/4.1.30.Final/netty-codec-http-4.1.30.Final-sources.jar"} , "name": "io-netty-netty-codec-http", "actual": "@io-netty-netty-codec-http//jar", "bind": "jar/io/netty/netty-codec-http"},
    {"artifact": "io.netty:netty-codec-socks:4.1.30.Final", "lang": "java", "sha1": "ea272e3bb281d3a91d27278f47e61b4de285cc27", "sha256": "cff97f4b618ab0a1a3664bc1716a98389d477f6c1412275af34cb8e60cd3f1a9", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-codec-socks/4.1.30.Final/netty-codec-socks-4.1.30.Final.jar", "source": {"sha1": "f9a0e618f41ae84734a745880d0cfd9a6d1d6f6f", "sha256": "8ccebe1622039f6eba7f856caa810c185eac936a8492ff7be9b2f0318c36f932", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-codec-socks/4.1.30.Final/netty-codec-socks-4.1.30.Final-sources.jar"} , "name": "io-netty-netty-codec-socks", "actual": "@io-netty-netty-codec-socks//jar", "bind": "jar/io/netty/netty-codec-socks"},
    {"artifact": "io.netty:netty-codec:4.1.30.Final", "lang": "java", "sha1": "515c8f609aaca28a94f984d89a9667dd3359c1b1", "sha256": "ca9873b1a4419dd3d5455afa8351279e5c9c834b86118c5e345ff7751492bd30", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-codec/4.1.30.Final/netty-codec-4.1.30.Final.jar", "source": {"sha1": "5c9148c433a3d5869981aac0b5d8ee1b83f727e6", "sha256": "c21e2f8a03ef837bf6fb7758633c7810fe02b32f12716195c1f7b016999f5497", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-codec/4.1.30.Final/netty-codec-4.1.30.Final-sources.jar"} , "name": "io-netty-netty-codec", "actual": "@io-netty-netty-codec//jar", "bind": "jar/io/netty/netty-codec"},
    {"artifact": "io.netty:netty-common:4.1.30.Final", "lang": "java", "sha1": "5dca0c34d8f38af51a2398614e81888f51cf811a", "sha256": "b5f23d82aab356751db417829536267886ad835d314b4ae4425736cf8a0a9a2a", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-common/4.1.30.Final/netty-common-4.1.30.Final.jar", "source": {"sha1": "bbe24e82b2e153dc9bfaa01c63c0dd47c71f2e59", "sha256": "25de2f42d1bc6809f02f14239326fcfc54109ebe9dd88dc7460e604cd90dcde5", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-common/4.1.30.Final/netty-common-4.1.30.Final-sources.jar"} , "name": "io-netty-netty-common", "actual": "@io-netty-netty-common//jar", "bind": "jar/io/netty/netty-common"},
    {"artifact": "io.netty:netty-handler-proxy:4.1.30.Final", "lang": "java", "sha1": "1baa1568fa936caddca0fae96fdf127fd5cbad16", "sha256": "8553f0eaac3a21f25e485eb5191d21c69837deb5acc74b9cdf987820eaee3b54", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-handler-proxy/4.1.30.Final/netty-handler-proxy-4.1.30.Final.jar", "source": {"sha1": "88ef22e28a471ffe6f845c6971b56a7fcc446199", "sha256": "11b233fc1998b9c7960af1520cba1d3de181ed938d12efed1b28abda2b9ebdb3", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-handler-proxy/4.1.30.Final/netty-handler-proxy-4.1.30.Final-sources.jar"} , "name": "io-netty-netty-handler-proxy", "actual": "@io-netty-netty-handler-proxy//jar", "bind": "jar/io/netty/netty-handler-proxy"},
    {"artifact": "io.netty:netty-handler:4.1.30.Final", "lang": "java", "sha1": "ecc076332ed103411347f4806a44ee32d9d9cb5f", "sha256": "416a61a489ebddb668a721401bb08ee0796768801ec27cf05f5e528c76236e8d", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-handler/4.1.30.Final/netty-handler-4.1.30.Final.jar", "source": {"sha1": "537c70ab45c414e08aacb8c2c17e407752073ce7", "sha256": "eef70f9cf7bb8af2394be8ab86080f475a651455bd3a548092c3fd8fb35405f7", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-handler/4.1.30.Final/netty-handler-4.1.30.Final-sources.jar"} , "name": "io-netty-netty-handler", "actual": "@io-netty-netty-handler//jar", "bind": "jar/io/netty/netty-handler"},
    {"artifact": "io.netty:netty-resolver:4.1.30.Final", "lang": "java", "sha1": "5106fd687066ffd712e5295d32af4e2ac6482613", "sha256": "c975aed0421009c6f762afa4d7182eee51a9fc00f3d238f24950e2225c3e882f", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-resolver/4.1.30.Final/netty-resolver-4.1.30.Final.jar", "source": {"sha1": "f2006616cc4c05263eb2c8cf3187109e1710b6dd", "sha256": "0d8d0e340394baf39e6de46d1da6df25ee06c05d7e47824bdaf19ad5b4e3b44a", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-resolver/4.1.30.Final/netty-resolver-4.1.30.Final-sources.jar"} , "name": "io-netty-netty-resolver", "actual": "@io-netty-netty-resolver//jar", "bind": "jar/io/netty/netty-resolver"},
    {"artifact": "io.netty:netty-transport:4.1.30.Final", "lang": "java", "sha1": "3d27bb432a3b125167ac161b26415ad29ec17f02", "sha256": "8b2ac95f7ad8ba53847a7724e45b5d68ebc84bb058093f493424df9fc2ecf2fa", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-transport/4.1.30.Final/netty-transport-4.1.30.Final.jar", "source": {"sha1": "de1b7fc8e484050f5879722dfe0e13378229bee4", "sha256": "d5d8e4d9845cdfa9f6bcbf52f96870963f63a94f79fb65139b4c2d33886c389c", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-transport/4.1.30.Final/netty-transport-4.1.30.Final-sources.jar"} , "name": "io-netty-netty-transport", "actual": "@io-netty-netty-transport//jar", "bind": "jar/io/netty/netty-transport"},
    {"artifact": "io.opencensus:opencensus-api:0.12.3", "lang": "java", "sha1": "743f074095f29aa985517299545e72cc99c87de0", "sha256": "8c1de62cbdaf74b01b969d1ed46c110bca1a5dd147c50a8ab8c5112f42ced802", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/opencensus/opencensus-api/0.12.3/opencensus-api-0.12.3.jar", "source": {"sha1": "09c2dad7aff8b6d139723b9181ba5da3f689213b", "sha256": "67e8b2120737c7dcfc61eef33f75319b1c4e5a2806d3c1a74cab810650ac7a19", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/opencensus/opencensus-api/0.12.3/opencensus-api-0.12.3-sources.jar"} , "name": "io-opencensus-opencensus-api", "actual": "@io-opencensus-opencensus-api//jar", "bind": "jar/io/opencensus/opencensus-api"},
    {"artifact": "io.opencensus:opencensus-contrib-grpc-metrics:0.12.3", "lang": "java", "sha1": "a4c7ff238a91b901c8b459889b6d0d7a9d889b4d", "sha256": "632c1e1463db471b580d35bc4be868facbfbf0a19aa6db4057215d4a68471746", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/opencensus/opencensus-contrib-grpc-metrics/0.12.3/opencensus-contrib-grpc-metrics-0.12.3.jar", "source": {"sha1": "9a7d004b774700837eeebff61230b8662d0e30d1", "sha256": "d54f6611f75432ca0ab13636a613392ae8b7136ba67eb1588fccdb8481f4d665", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/opencensus/opencensus-contrib-grpc-metrics/0.12.3/opencensus-contrib-grpc-metrics-0.12.3-sources.jar"} , "name": "io-opencensus-opencensus-contrib-grpc-metrics", "actual": "@io-opencensus-opencensus-contrib-grpc-metrics//jar", "bind": "jar/io/opencensus/opencensus-contrib-grpc-metrics"},
    {"artifact": "org.antlr:antlr4-runtime:4.7.1", "lang": "java", "sha1": "946f8aa9daa917dd81a8b818111bec7e288f821a", "sha256": "43516d19beae35909e04d06af6c0c58c17bc94e0070c85e8dc9929ca640dc91d", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/antlr/antlr4-runtime/4.7.1/antlr4-runtime-4.7.1.jar", "source": {"sha1": "1e68e18aa14f3229b95820d354a594846134af38", "sha256": "a33d52d0d64e68c60d5e3ae2c1098fe7200d57cff59032c19930fd9d487fc7d4", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/antlr/antlr4-runtime/4.7.1/antlr4-runtime-4.7.1-sources.jar"} , "name": "org-antlr-antlr4-runtime", "actual": "@org-antlr-antlr4-runtime//jar", "bind": "jar/org/antlr/antlr4-runtime"},
    {"artifact": "org.checkerframework:checker-compat-qual:2.5.2", "lang": "java", "sha1": "dc0b20906c9e4b9724af29d11604efa574066892", "sha256": "d7291cebf5e158d169807ae49d4b16ff672986f0c6d803e5f207c40cb61ef982", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/checkerframework/checker-compat-qual/2.5.2/checker-compat-qual-2.5.2.jar", "source": {"sha1": "420d8098e865794623d5e412445f8d2adea0bd54", "sha256": "27e52153bbdf10adcd39eaf3acdcb7a27e70dce22545a0a37121fa02429322ca", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/checkerframework/checker-compat-qual/2.5.2/checker-compat-qual-2.5.2-sources.jar"} , "name": "org-checkerframework-checker-compat-qual", "actual": "@org-checkerframework-checker-compat-qual//jar", "bind": "jar/org/checkerframework/checker-compat-qual"},
# duplicates in org.codehaus.mojo:animal-sniffer-annotations promoted to 1.17
# - com.google.guava:guava:26.0-android wanted version 1.14
# - io.grpc:grpc-core:1.16.0 wanted version 1.17
    {"artifact": "org.codehaus.mojo:animal-sniffer-annotations:1.17", "lang": "java", "sha1": "f97ce6decaea32b36101e37979f8b647f00681fb", "sha256": "92654f493ecfec52082e76354f0ebf87648dc3d5cec2e3c3cdb947c016747a53", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/codehaus/mojo/animal-sniffer-annotations/1.17/animal-sniffer-annotations-1.17.jar", "source": {"sha1": "8fb5b5ad9c9723951b9fccaba5bb657fa6064868", "sha256": "2571474a676f775a8cdd15fb9b1da20c4c121ed7f42a5d93fca0e7b6e2015b40", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/codehaus/mojo/animal-sniffer-annotations/1.17/animal-sniffer-annotations-1.17-sources.jar"} , "name": "org-codehaus-mojo-animal-sniffer-annotations", "actual": "@org-codehaus-mojo-animal-sniffer-annotations//jar", "bind": "jar/org/codehaus/mojo/animal-sniffer-annotations"},
# duplicates in org.slf4j:slf4j-api promoted to 1.7.25
# - ch.qos.logback:logback-classic:1.2.3 wanted version 1.7.25
# - io.grakn.client:grakn-client:1.6.1 wanted version 1.7.20
# - io.graql:graql-lang:1.0.5 wanted version 1.7.20
    {"artifact": "org.slf4j:slf4j-api:1.7.25", "lang": "java", "sha1": "da76ca59f6a57ee3102f8f9bd9cee742973efa8a", "sha256": "18c4a0095d5c1da6b817592e767bb23d29dd2f560ad74df75ff3961dbde25b79", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/slf4j/slf4j-api/1.7.25/slf4j-api-1.7.25.jar", "source": {"sha1": "962153db4a9ea71b79d047dfd1b2a0d80d8f4739", "sha256": "c4bc93180a4f0aceec3b057a2514abe04a79f06c174bbed910a2afb227b79366", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/slf4j/slf4j-api/1.7.25/slf4j-api-1.7.25-sources.jar"} , "name": "org-slf4j-slf4j-api", "actual": "@org-slf4j-slf4j-api//jar", "bind": "jar/org/slf4j/slf4j-api"},
    ]

def maven_dependencies(callback = jar_artifact_callback):
    for hash in list_dependencies():
        callback(hash)
