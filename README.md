###  服务端结构
> 风行者系统
>
> > Shell监视程式
>
>  > > C监视程式
>
> > > > PluggableTransports + Squid


###  客户端结构
> 监听模块
>
> > 代理模块
>
>  > > 心跳模块(C/S同步技术)
>
> > > > AutoUpdate 模块




## 0.2.20更新日志

* 加入对ADSl网络环境的支持
* 修正了0.2.1 delphi内存管理dll扩展文件缺失的bug
* 优化了功能
* 提供了使用说明文档
* 新加特性: ProxySetting.dll 模块加入对高度匿名的支持  =>0.2.3
* 新加特性: 主菜单加入高度匿名功能 =>0.2.3
* 新加特性:去除引起杀毒软件误报的释放资源功能的函数,改用直接从雪豹当前目录读取PAC文件,效率更高=>0.2.5
* 新加特性: 加入备用服务器功能=>0.2.7
* 新加特性:加入多个服务器节点的检测功能=>0.2.7
* 新加特性: 加入智能切换排错功能=>0.2.7
* 新加特性: 加入保护功能rc4加密=>0.2.9
* 修正特性 修正切换到主服务器出错无法代理的bug=>0.2.10
* 新加特性: 提供动态升级图标功能=>0.2.10
* 新加特性: 加入独有心跳功能,客户端和服务端会同步更新=>0.2.13
* 新加特性: 提高心跳功能算法,客户端服务器菜单无人值守自主切换=>0.2.14
* 修正: 修正备用服务器全局部分bug =>0.2.15
* 新加特性: 加入最具稳定性的混淆技术Obfsproxy套件=>0.2.16
* 新加特性: 优化了启动速度,1秒之内雪豹完成启动,修正了混淆服务器和其他服务器之间切换的bug,去除了切换服务器显示的多余功能=>0.2.17
* 新加特性: 加入安全的许可证验证机制=>0.2.18
* 新加特性: 加入心跳功能监视模块=>0.2.19
* 新加特性: 优化心跳功能算法和使用UPX等压缩技术=>0.2.19.2
* 新加特性: 服务器默认使用obfs4混淆技术=>0.2.20.0
* [10/3/2016]新加特性: 优化针对混淆服务器的同步系统功能=>0.2.20.1
* [10/3/2016]新加特性: 混淆服务器使用全新全局模式函数=>0.2.20.1
* [10/3/2016]新加特性: 加入对网络状态的判断=>0.2.20.1
