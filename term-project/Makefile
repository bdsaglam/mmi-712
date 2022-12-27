.PHONY: install

install-external-packages:
	@pip3 install --no-deps --find-links https://download.pytorch.org/whl/torch_stable.html --find-links https://pytorch-geometric.com/whl/torch-1.7.0+cpu.html -r requirements-lock-external.txt

install-tractable-packages:
	@pip3 install --no-deps -r requirements-lock-tractable.txt

install-lint-packages:
	@pip3 install --no-deps -r requirements-lint.txt

install-packages: install-external-packages install-tractable-packages

update-top-level-packages:
	@pip3 install -U -r requirements.txt

create-lock-files:
	pip3 freeze | sed -e 's/^-e //g' | sed -e '/metadata-classifiers.git/d' | sed -e '/pkg-resources/d' > requirements-lock.txt
	TORCH_VERSION=$$(cat requirements-lock.txt | grep torch== | cut -d'=' -f 3 | cut -d'+' -f 1); \
	sed -i '/torch==/d' requirements-lock.txt; \
	echo "torch==$$TORCH_VERSION; sys_platform == 'darwin'" >> requirements-lock.txt; \
	echo "torch==$$TORCH_VERSION+cpu; sys_platform != 'darwin'" >> requirements-lock.txt; \
	cat requirements-lock.txt | grep -E "xmachinas|tractableai" > requirements-lock-tractable.txt; \
	cat requirements-lock.txt | grep -E -v "xmachinas|tractableai" > requirements-lock-external.txt; \
	rm requirements-lock.txt; \
	echo "Created: \nrequirements-lock-tractable.txt \nrequirements-lock-external.txt"

update-packages: update-top-level-packages create-lock-files