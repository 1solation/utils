# Use Kotlin on mac & use VS Code

Note: This is probably not the best way to develop production grade code since Jet Brains created Kotlin and the IntelliJ IDE, however, it's a nice middle ground of trying out Kotlin within the familiar setting of VS Code.

## Installation

1. Kotlin is included in each release of IntelliJ IDEA. Download & install IntelliJ IDEA CE dependent on if your mac has Intel or Apple Silicon --> https://www.jetbrains.com/idea/download/#section=mac
	- If you don't have the latest JDK already installed on your computer, download the latest JDK here https://www.oracle.com/java/technologies/downloads/#jdk20-mac

	- Verify installation by executing the following in the terminal
	```bash
	java -version && javac -version
	```

2. Use homebrew to install the latest version of Kotlin to allow us to use the Kotlin command-line compiler
	```bash
	brew update && brew install kotlin
	```

	- Verify installation by executing the following in the terminal `kotlin`, which should bring up Kotlin REPL shell
	- Execute the following code to make sure everything works
	```kotlin
	val msg: String = "Hello world"
	println(msg)
	```
3. If you want to use Kotlin with VS Code install the following extensions on VS Code:
	- `mathiasfrohlich.Kotlin` for Kotlin language support
	- `formulahendry.code-runner` which is a CodeRunner for VsCode which can run multiple programming languages, with shortcuts

## Development

### Build

To build a Kotlin project, we can use 2 methods.

1. We can use the code-runner VS Code extension. This code runner will automatically invoke the compile command and run the application afterward.
2. Create a task file. In the `.vscode` directory, create a file named `tasks.json`. Copy the following into it as a template
```json
{
  // For documentation on tasks.json format see https://code.visualstudio.com/docs/editor/tasks#vscode
  "version": "2.0.0",
  "tasks": [
    {
      "label": "echo",
      "type": "shell",
      "command": "kotlinc main.kt -include-runtime -d main.jar",
      "group": {
        "kind": "build",
        "isDefault": true
      }
    }
  ]
}
```

3. You can now build using the `cmd + shift + B` shortcut or opening up the command palette with `cmd + shift + P` and typing `>Tasks: Run Build Task`

### Run

To run Kotlin code, we can right click and select `Run Code`, or use the shortcut `control + option + N`

We can also run Kotlin code from the terminal, using the executable jar file that was created during the build step. In the correct directory, execute the following on the terminal

```bash
java -jar Main.jar
```
