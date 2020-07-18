plugins {
    application
    id("org.jetbrains.kotlin.jvm") // todo plugin
}

// repositories {
//     jcenter()
// }

application {
    mainClassName = "stan.kjfex.sample.AppKt"
}

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib:1.3.61") // todo version
}
