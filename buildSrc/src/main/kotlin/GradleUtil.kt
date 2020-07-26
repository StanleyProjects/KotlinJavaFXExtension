import org.gradle.api.Project
import org.gradle.api.initialization.dsl.ScriptHandler
import org.gradle.api.tasks.SourceSet
import org.gradle.api.tasks.SourceSetContainer
import org.gradle.kotlin.dsl.DependencyHandlerScope
import org.gradle.kotlin.dsl.ScriptHandlerScope
import org.gradle.kotlin.dsl.dependencies
import org.gradle.kotlin.dsl.get
import org.gradle.kotlin.dsl.project
import org.gradle.kotlin.dsl.the
import org.gradle.kotlin.dsl.version
import org.gradle.plugin.use.PluginDependenciesSpec

fun Dependency.notation(): String {
    return "$group:$name:$version"
}

fun Iterable<Dependency>.notation(): Iterable<String> {
    return map { it.notation() }
}

fun DependencyHandlerScope.addClasspath(dependency: Dependency) {
    add(ScriptHandler.CLASSPATH_CONFIGURATION, dependency.notation())
}

fun ScriptHandlerScope.dependencies(
    firstDependency: Dependency,
    vararg otherDependencies: Dependency
) {
    dependencies.addClasspath(firstDependency)
    otherDependencies.forEach(dependencies::addClasspath)
}

fun DependencyHandlerScope.classpathAll(
    dependencyFirst: Dependency,
    dependencySecond: Dependency,
    vararg dependencyOther: Dependency
) {
    addClasspath(dependencyFirst)
    addClasspath(dependencySecond)
    dependencyOther.forEach(::addClasspath)
}

fun DependencyHandlerScope.implementation(dependency: Dependency) {
    add("implementation", dependency.notation())
}

fun DependencyHandlerScope.addAll(configuration: String, dependencies: Set<String>) {
    dependencies.forEach {
        add(configuration, it)
    }
}

fun DependencyHandlerScope.addAll(
    firstPair: Pair<String, Set<Dependency>>,
    vararg pair: Pair<String, Set<Dependency>>
) {
    addAll(configuration = firstPair.first, dependencies = firstPair.second.notation().toSet())
    pair.forEach { (configuration, dependencies) ->
        addAll(configuration = configuration, dependencies = dependencies.notation().toSet())
    }
}

fun Project.dependencies(
    projects: Map<String, Set<String>>,
    dependencies: Map<String, Set<Dependency>>
) {
    dependencies {
        projects.forEach { (configuration, dependencies) ->
            dependencies.forEach { path ->
                configuration(project(path))
            }
        }
        dependencies.forEach { (configuration, set) ->
            addAll(configuration, dependencies = set.notation().toSet())
        }
    }
}

fun Project.dependencies(
    firstPair: Pair<String, Set<Dependency>>,
    vararg pair: Pair<String, Set<Dependency>>
) {
    DependencyHandlerScope.of(dependencies).addAll(firstPair, *pair)
}

fun DependencyHandlerScope.implementationProject(
    projectName: String
) {
    add("implementation", project(projectName))
}

fun DependencyHandlerScope.implementationProjects(
    projectNameFirst: String,
    projectNameSecond: String,
    vararg projectNameOther: String
) {
    implementationProject(projectNameFirst)
    implementationProject(projectNameSecond)
    projectNameOther.forEach(::implementationProject)
}

fun PluginDependenciesSpec.apply(plugin: Plugin, isWithVersion: Boolean = false) {
    if (isWithVersion) {
        id(plugin.name) version plugin.version
    } else {
        id(plugin.name)
    }
}

fun PluginDependenciesSpec.applyAll(
    firstPlugin: Plugin,
    secondPlugin: Plugin,
    vararg other: Plugin
) {
    apply(firstPlugin)
    apply(secondPlugin)
    other.forEach(::apply)
}

fun Project.sourceSet(name: String): SourceSet {
    return the<SourceSetContainer>()[name] ?: error(
        "Source set by name: $name must be exists in project: ${project.name}"
    )
}
