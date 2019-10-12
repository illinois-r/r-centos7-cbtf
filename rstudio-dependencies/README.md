## Dependency Manager

RStudio lists _R_ package dependencies in `DependencyManager.java`. This
can be accessed via:

<https://github.com/rstudio/rstudio/blob/master/src/gwt/src/org/rstudio/studio/client/common/dependencies/DependencyManager.java>

Download a copy via:

```r
download.file(
    "https://github.com/rstudio/rstudio/blob/master/src/gwt/src/org/rstudio/studio/client/common/dependencies/DependencyManager.java?raw=1",
    "rstudio-dependencies/DependencyManager.java"
)
```

### Format

Data style:

```java
Dependency.cranPackage("htmltools", "0.3.6")
```

**Goal:** Retrieve "htmltools"

Search pattern is should be:

```
.*\.cranPackage\("(.*?)".*
```
