<!-- CSS -->
<link rel="stylesheet" href="modules/servers/shadowsocks/templates/static/css/style.css">



<div class="plugin">
    <div class="row">



        <div class="col-md-12">

            <!--widget start-->

            <aside class="profile-nav alt hidden-xs">

                <section class="panel">

                    <div class="user-heading alt gray-bg">

                        <a href="#">

                            <img src="https://secure.gravatar.com/avatar/{$params.clientsdetails.email|md5}?s=128" alt="">

                        </a>

                        <h1>{$params.clientsdetails.firstname} {$params.clientsdetails.lastname}</h1>

                        <p>{$params.clientsdetails.fullstate} - {$params.clientsdetails.country}</p>

                    </div>



                    <ul class="nav nav-pills nav-stacked">

                        <li><a href="javascript:;"> <i class="fa fa-calendar-check-o"></i> {$LANG.clientareahostingregdate} : {$regdate} </a></li>

                        <li><a href="javascript:;"> <i class="fa fa-list-alt"></i> {$LANG.orderproduct} : {$groupname} - {$product} </a></li>

                        <li><a href="javascript:;"> <i class="fa fa-money"></i> {$LANG.orderpaymentmethod} : {$paymentmethod} {$LANG.firstpaymentamount}({$firstpaymentamount}) - {$LANG.recurringamount}({$recurringamount})</a></li>

                        <li><a href="javascript:;"> <i class="fa fa-spinner"></i> {$LANG.clientareahostingnextduedate} : {$nextduedate} {$LANG.orderbillingcycle}({$billingcycle}) </a></li>

                        <li><a href="javascript:;"> <i class="fa fa-check-square-o"></i> {$LANG.clientareastatus} : {$status} </a></li>

                        {foreach from=$productcustomfields item=customfield}

                            <li><a href="javascript:;"> <i class="fa fa-file-text"></i> {$customfield.name} : {$customfield.rawvalue} </a></li>

                        {/foreach}

                        

                    </ul>



                </section>

            </aside>

            <!--widget end-->
            
            <section class="panel">
                
                <header class="panel-heading">
                    用户信息
                </header>

                <div class="panel-body">
                        
                    <table class="table general-table">
                        <thead>
                            <tr>
                                <th>端口</th>
                                <th>密码</th>
                                <th class="hidden-xs">创建时间</th>
                                <th class="hidden-sm hidden-xs">上次使用</th>
                                <th class="hidden-sm hidden-xs">上次重置</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>{$usage.port}</td>
                                <td>{$usage.passwd}</td>
                                <td class="hidden-xs">{$usage.created_at|date_format:'%Y-%m-%d %H:%M:%S'}</td>
                                <td class="hidden-sm hidden-xs">{$usage.t|date_format:'%Y-%m-%d %H:%M:%S'}</td>
                                
                                {if $usage.updated_at eq '0'}
                                <td class="hidden-sm hidden-xs">暂无数据</td>
                                {else}
                                <td class="hidden-sm hidden-xs">{$usage.updated_at|date_format:'%Y-%m-%d %H:%M:%S'}</td>
                                {/if}
                            </tr>
                        </tbody>
                    </table>

                </div>

            </section>


            <!--progress bar start-->

            <section class="panel">

                <header class="panel-heading">
                    使用报表 (总流量：{$usage.transfer_enable/1048576} MB)
                </header>
                <div class="panel-body" id="plugin-usage">

                    <p>已用流量 ({($usage.sum/1048576)|round} MB)</p>

                    <div class="progress progress-striped progress-sm">

                        <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="{($usage.sum/$usage.transfer_enable)*100}" aria-valuemin="0" aria-valuemax="100" style="width: {($usage.sum/$usage.transfer_enable)*100}%">

                            <span class="sr-only">{($usage.sum/$usage.transfer_enable)*100}% Complete</span>

                        </div>

                    </div>

                    <p>上传流量 ({($usage.u/1048576)|round} MB)</p>

                    <div class="progress progress-striped progress-sm">

                        <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="{($usage.u/$usage.transfer_enable)*100}" aria-valuemin="0" aria-valuemax="100" style="width: {($usage.u/$usage.transfer_enable)*100}%">

                            <span class="sr-only">{($usage.u/$usage.transfer_enable)*100}% Complete (warning)</span>

                        </div>

                    </div>

                    <p>下载流量 ({($usage.d/1048576)|round} MB)</p>

                    <div class="progress progress-striped progress-sm">

                        <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="{($usage.d/$usage.transfer_enable)*100}" aria-valuemin="0" aria-valuemax="100" style="width: {($usage.d/$usage.transfer_enable)*100}%">

                            <span class="sr-only">{($usage.d/$usage.transfer_enable)*100}% Complete (danger)</span>

                        </div>

                    </div>

                </div>

            </section>

            <!--progress bar end-->



            <section class="panel">

                <header class="panel-heading">

                    节点列表

                </header>

                <div class="panel-body">

                    <table class="table table-hover general-table">

                        <thead>

                            <tr>

                                <th class="hidden-xs" width="20%">描述</th>

                                <th width="30%">地址</th>

                                <th width="10%">加密</th>

                                <th width="10%">状态</th>

                                <th class="hidden-xs hidden-sm" width="20%">操作</th>

                            </tr>

                        </thead>

                        <tbody>

                            {foreach from=$nodes key=k item=node }

                            <tr>

                                <td class="hidden-xs">{$node[0]}</td>
                                <td>{$node[1]}</td>
                                <td>{$node[2]}</td>
                                <td data-hook="status">

                                    <button name="ping" class="btn btn-primary btn-xs" data-host="{$node[1]|trim}">
                                        <i class="fa fa-eye"></i>
                                        获取状态
                                    </button>

                                </td>

                                <td class="hidden-xs hidden-sm" data-hook="action">

                                    <button name="qrcode" class="btn btn-primary btn-xs" data-params="{$node[2]|trim}:{$usage.passwd|trim}@{$node[1]|trim}:{$usage.port|trim}">
                                        <i class="fa fa-qrcode"></i>
                                        二维码
                                    </button>

                                    <button name="download" class="btn btn-primary btn-xs hidden-md" data-params="{$node[2]|trim}|{$usage.passwd|trim}|{$node[1]|trim}|{$usage.port|trim}">
                                        <i class="fa fa-file-o"></i>
                                        配置文件
                                    </button>

                                </td>

                            </tr>

                            {/foreach}

                        </tbody>

                    </table>

                </div>

            </section>

        </div>

    </div>
    <div id="qrcode">
        
        <section class="panel">

            <header class="panel-heading">
                二维码
                
                <div class="pull-right">
                    <a href="javascript:void(0)" id="close-qrcode"><i class="fa fa-times"></i></a>
                </div>
            </header>

            <div class="panel-body">
                
                <div class="row">
                    <img id="qrcode-src" src="" alt="">
                </div>

            </div>
            
        </section>

    </div>
</div>


<!-- JavsScript -->
<script src="modules/servers/shadowsocks/templates/static/js/script.js"></script>