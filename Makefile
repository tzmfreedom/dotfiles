CANDIDATES := $(wildcard .??*)
EXCLUSIONS := ".DS_Store" ".git" ".gitignore" ".gitmodules"
DOTFILES := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

all:

.PHONY: install
install:
	$(foreach file, $(DOTFILES), ln -sf $(abspath $(file)) $(HOME)/$(file);)

update:
	git pull origin master
	make install

.PHONY: hello
hello:
	@$(foreach file, $(DOTFILES), echo $(abspath $(file));echo $(HOME)/$(file);)
