define FOREACH
    for DIR in ./*; do \
        $(MAKE) -C $$DIR $(1); \
    done
endef

export BUILD_DATE?=$(shell date +"%Y%m%d")
export BASE_IMAGE?=fr123k/circleci-base:${BUILD_DATE}_${GIT_COMMIT}

build-all: $(SUBDIRS)
	$(call FOREACH,build)
