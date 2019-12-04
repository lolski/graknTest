java_library(
    name = "grakn-test",
    deps = [
        "//dependencies/maven/artifacts/io/grakn/client:grakn-client",
        "//dependencies/maven/artifacts/io/grakn/protocol:grakn-protocol",
        "//dependencies/maven/artifacts/io/graql:graql-lang",
        ],
    srcs = glob(["quickstart/*.java"]),
)

java_binary(
    name = "grakn-test-bin",
    main_class = "quickstart.GraknQuickstartA",
    runtime_deps = ["grakn-test"]
)