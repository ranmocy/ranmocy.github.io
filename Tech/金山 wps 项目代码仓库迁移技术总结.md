---
title: 金山 WPS 项目代码仓库迁移技术总结
created_at: 2013-07-15T21:34:50+08:00
updated_at: 2013-07-15T21:34:50+08:00
category: Tech
---

代码是机密，也是签过保密协议的。
但是迁移过程不是，这些属于我们研究过程的东西，应该是可以开放出来的。

金山方面希望我们帮助他们将原本使用的 SVN 库转移到 Git 格式，
Git 是由 Linux 之父 Linus 创造出来的，为 Linux 内核的多人合作模式提供支持。

目标对象是金山 WPS 项目的代码仓库，这个仓库的第一个版本历史是 2004 年的，
至今已经开发了将近 10 年的时间，代码仓库有 20G+，20w+ 的版本记录，算是个大工程。
每次签出一个版本都要半个小时以上的时间，以至于他们不敢频繁切换版本。
这非常不利于敏捷的进行开发。所以他们决定要迁移整个项目到更为快捷和自由方便的 Git 上来。

他们尝试自己使用 Git 的官方工具 git-svn 来做迁移，但是中间出现了问题，所以希望我们帮忙来转。

既然 git-svn 进行转换会报错，那么我们就换一个工具。后来我找到了 SubGit，进行尝试转换。SubGit 是一款商业软件，专门做 SVN 与 Git 之间的无缝合作。我选择这款软件的原因也是因为处理的项目是商业项目，稳定性很重要，所以开始的时候选择使用 SubGit 来进行转换，但是效率很快成为项目进度的瓶颈。

后来尝试使用 svn2git 工具，效率非常高，但是直接分库也会出现错误。

git-svn 是用 Perl 语言写的；转换了一周的时间，转换了三分之二的项目，出现了很多问题，被金山方面所终止。寻求我们的帮助；
SubGit 是用 Java 语言写的；8个小时就转换了10万条，但是之后速度马上就下降到每天五千条左右。效率成为主要的影响因素。
svn2git 是用 C++ 语言写的。当年作为 KDE 项目组从 SVN 迁移到 Git 而自行开发的程序。程序基于自己定义的匹配规则可以在转换格式的同时进行代码库的拆分。它对所有的修改进行路径匹配，将修改分配到第一条匹配到的规则所指定的库和分支，全部代码库转换总共用时2天。整库转换非常顺利，但是如果同时进行分库的话，会出现错误。错误出现在新建分支的时候，如果是父目录新建出来的分支，那么匹配子目录的规则则不会按照期望新建分支。导致后续的修改找不到该分支。

### 拆库

由于 Git 的设计初始就是为了开源社区超高并发协作而设计的，没有 SVN 自带的权限管理，但是企业又非常重视和强调代码的权限控制，而且并非是简单的不可以写，而是有些核心代码不可读，而且是基于目录而不是基于分支的。

Git 的常规做法是利用 submodule 的方式进行目录的拆分，使得目录作为一个独立的仓库而存在。然后利用 SSH 或是 HTTPS 进行读写的权限管理。




