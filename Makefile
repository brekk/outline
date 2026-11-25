SRC_DIR := ./src
BUILD_DIR := ./build
EXEC := outline

$(BUILD_DIR)/$(EXEC): $(SRC_DIR)/*.mad
	mkdir -p $(dir $@)
	echo "compiling! - outline"
	madlib compile -i src/Main.mad -t llvm -o $@
	echo "built! - outline"

version.lock:
	madlib install

README.md: madlib.json
	pilcrow -i README.md --repo brekk/outline --auto

src/Version.mad: madlib.json
	cat madlib.json | jq ".version" | sed '1s@^@export VERSION = @' > src/Version.mad

.PHONY: clean
clean:
	rm -r $(BUILD_DIR)
