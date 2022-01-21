# shellfun_factory

往标准输出怼一坨 SHell 函数定义代码的函数。

这大概是元编程，不过现在尚未找到把子环境里的定义直接应用于当前环境的方法，所以我认为这是不完善的元编程。

## 项

### `podman_app_def`

取得本目录下的 [`podman_toy.bash`](./podman_toy.bash) 文件，并执行 `source` （或类似性质的操作）后，即可使用此函数。

#### 功能

定义一个实际是调用 `podman run --rm` 的函数，然后……然后把这个定义扔进 `stdout` ——就是说，你可以用 `>` 重定向成文件，也可以只是打印到屏幕上看看（默认就是只看看）。

#### 说明

第一个参数是工具本来的名字：

- 它会是输出定义的函数名
- 它也是这个函数定义里调用 `podman` 的时候 *入口程序* 名（就是说这程序启动的进程容器内进程号为 `1` ）

第二个参数是它的镜像的名字——如果留空则自动使用工具名。

#### 使用示例

以 `pypy` 为例：

~~~ sh
podman_app_def pypy pypy:slim > src # 输出到文件
source src # 文件里会有个名为 pypy 的定义   source 后就可以用了
pypy --version # 可以用各种选项  这个程序也只会影响当前目录（由于在容器内）
~~~

更新：

~~~ sh
podman pull pypy:slim
~~~

如果是 `elvish` 的话：

~~~ sh
podman_app_def elvish docker.io/theelves/elvish > src && . src
elvish --version
~~~

#### 灵感来源

来自 `pypy` 的 DockerHub 页面的使用示例。

你们也可以试试别的，比如 `luajit` 。（其实 `luajit` 反而没必要，这东西直接装就行，才几百 `KiB` 大小。。。当然，万一是在离线环境还又搞不定普通的安装的话，就还是用 OCI 镜像吧。。。）

#### 一些遗憾

其实我的期望是这样使用：

定义只需如此

~~~~ bash
`podman_app_def pypy pypy:slim`
~~~~

然后我就能直接用了

~~~ sh
pypy --version
type pypy # 会说这是个函数
~~~

对于 `elvish` 也是同理，我期望只是这样我就可以去使用这个命令了（因为它已经是定义好了的函数）：

~~~~ bash
`podman_app_def elvish docker.io/theelves/elvish`
~~~~

**然而别说 Bash ，就是 Zsh 都做不了这事儿！**

这就是遗憾了。。。。

（至于 `elvish` 的话是使用了完全不同的语法了。我还不知道要怎么把子环境得出的定义应用于当前环境，所以在它里面的这件事，就先放置。）

### ...
