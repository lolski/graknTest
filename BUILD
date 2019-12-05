java_library(
    name = "grakn-test",
    srcs = glob(["quickstart/*.java"]),
    deps = [
        "//dependencies/maven/artifacts/io/grakn/client:grakn-client",
        "//dependencies/maven/artifacts/io/graql:graql-lang",
        "//dependencies/maven/artifacts/io/grakn/protocol:grakn-protocol",
        "//dependencies/maven/artifacts/io/grpc:grpc-netty"
    ],
)

java_binary(
    name = "grakn-test-bin",
    main_class = "quickstart.GraknQuickstartA",
    runtime_deps = ["grakn-test"]
)