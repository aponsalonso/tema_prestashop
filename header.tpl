{*
* 2007-2016 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2016 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}
<!DOCTYPE HTML>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7"{if isset($language_code) && $language_code} lang="{$language_code|escape:'html':'UTF-8'}"{/if}><![endif]-->
<!--[if IE 7]><html class="no-js lt-ie9 lt-ie8 ie7"{if isset($language_code) && $language_code} lang="{$language_code|escape:'html':'UTF-8'}"{/if}><![endif]-->
<!--[if IE 8]><html class="no-js lt-ie9 ie8"{if isset($language_code) && $language_code} lang="{$language_code|escape:'html':'UTF-8'}"{/if}><![endif]-->
<!--[if gt IE 8]> <html class="no-js ie9"{if isset($language_code) && $language_code} lang="{$language_code|escape:'html':'UTF-8'}"{/if}><![endif]-->
<html{if isset($language_code) && $language_code} lang="{$language_code|escape:'html':'UTF-8'}"{/if}>
	<head>
		<meta charset="utf-8" />
		<title>{$meta_title|escape:'html':'UTF-8'}</title>
		{if isset($meta_description) AND $meta_description}
			<meta name="description" content="{$meta_description|escape:'html':'UTF-8'}" />
		{/if}
		{if isset($meta_keywords) AND $meta_keywords}
			<meta name="keywords" content="{$meta_keywords|escape:'html':'UTF-8'}" />
		{/if}
		<meta name="generator" content="PrestaShop" />
		<meta name="robots" content="{if isset($nobots)}no{/if}index,{if isset($nofollow) && $nofollow}no{/if}follow" />
		<meta name="viewport" content="width=device-width, minimum-scale=0.25, maximum-scale=1.6, initial-scale=1.0" />
		<meta name="apple-mobile-web-app-capable" content="yes" />
		<link rel="icon" type="image/vnd.microsoft.icon" href="{$favicon_url}?{$img_update_time}" />
		<link rel="shortcut icon" type="image/x-icon" href="{$favicon_url}?{$img_update_time}" />
		<link href='http://fonts.googleapis.com/css?family=Open+Sans+Condensed:light&v1' rel='stylesheet' type='text/css'>
		<link href='https://fonts.googleapis.com/css?family=Open+Sans+Condensed:700' rel='stylesheet' type='text/css'>
		{if isset($css_files)}
			{foreach from=$css_files key=css_uri item=media}
				{if $css_uri == 'lteIE9'}
					<!--[if lte IE 9]>
					{foreach from=$css_files[$css_uri] key=css_uriie9 item=mediaie9}
					<link rel="stylesheet" href="{$css_uriie9|escape:'html':'UTF-8'}" type="text/css" media="{$mediaie9|escape:'html':'UTF-8'}" />
					{/foreach}
					<![endif]-->
				{else}
					<link rel="stylesheet" href="{$css_uri|escape:'html':'UTF-8'}" type="text/css" media="{$media|escape:'html':'UTF-8'}" />
				{/if}
			{/foreach}
		{/if}
		{if isset($js_defer) && !$js_defer && isset($js_files) && isset($js_def)}
			{$js_def}
			{foreach from=$js_files item=js_uri}
			<script type="text/javascript" src="{$js_uri|escape:'html':'UTF-8'}"></script>
			{/foreach}
		{/if}
		{$HOOK_HEADER}
		<link rel="stylesheet" href="//fonts.googleapis.com/css?family=Open+Sans:300,600&amp;subset=latin,latin-ext" type="text/css" media="all" />
        <link rel="stylesheet" href="{$css_dir}product_list.css" type="text/css" media="all" />
        <link rel="stylesheet" type="text/css" href="{$css_dir}slick.css">
        <link rel="stylesheet" type="text/css" href="{$css_dir}slick-theme.css">        
		<!--[if IE 8]>
		<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
		<script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
		<![endif]-->
		<script type="text/javascript" src="{$js_dir}jquery.wookmark.js"></script>
		<script type="text/javascript" src="{$js_dir}jquery.grid-a-licious.js"></script>
	</head>
	<body{if isset($page_name)} id="{$page_name|escape:'html':'UTF-8'}"{/if} class="{if isset($page_name)}{$page_name|escape:'html':'UTF-8'}{/if}{if isset($body_classes) && $body_classes|@count} {implode value=$body_classes separator=' '}{/if}{if $hide_left_column} hide-left-column{else} show-left-column{/if}{if $hide_right_column} hide-right-column{else} show-right-column{/if}{if isset($content_only) && $content_only} content_only{/if} lang_{$lang_iso}">
	{if !isset($content_only) || !$content_only}
		{if isset($restricted_country_mode) && $restricted_country_mode}
			<div id="restricted-country">
				<p>{l s='You cannot place a new order from your country.'}{if isset($geolocation_country) && $geolocation_country} <span class="bold">{$geolocation_country|escape:'html':'UTF-8'}</span>{/if}</p>
			</div>
		{/if}
		<div id="page">
			<div class="header-container">
				<header id="header" {if !$cookie->isLogged()}style="padding:0px;"{/if} >
					<div class="rem-header">

                        
						<div class="container">
							<div class="row">
                                {if isset($HOOK_TOP)}{$HOOK_TOP}{/if}
								<div id="header_logo">
									<a href="{if isset($force_ssl) && $force_ssl}{$base_dir_ssl}{else}{$base_dir}{/if}" title="{$shop_name|escape:'html':'UTF-8'}">
										<img class="logo img-responsive img-circle" src="{$img_dir}/mandala-color.jpg" alt="{$shop_name|escape:'html':'UTF-8'}"{if isset($logo_image_width) && $logo_image_width} w="{$logo_image_width}"{/if}{if isset($logo_image_height) && $logo_image_height} height="125" b="{$logo_image_height}"{/if}/>

                                    </a>

								</div>
                                <div class="header_shop_name col-sm-4">
                                <!-- {$shop_name} -->
                                	<span>
                                	<!-- TU PLANETA AZUL  -->
                                	</span>
                                </div>
                                <div class="header_user_menu col-sm-3 col-xs-12">

                                    <div class="sf-contener clearfix col-lg-12" id="block_top_right_menu" >


                                        <ul class="sf-menu clearfix menu-content sf-arrows">

                                            <li class="">
                                               <span> <span>
                                               		{if $is_logged}
                                                    <a href="#" title="{l s='Manage my customer account' mod='blockmyaccountfooter'}" rel="nofollow">
                                                    {else}
                                                    <a href="{$base_dir}login" title="{l s='Manage my customer account' mod='blockmyaccountfooter'}" rel="nofollow">
                                                    {/if}

                                                        <img class="imgm img-circle" alt="" src="http://profile.prestashop.com/jlmorales080%40gmail.com.jpg" width="66px" />
														{if $is_logged}
															{assign var="nombre" value=$cookie->customer_firstname}
															{l s=$nombre mod='blockmyaccountfooter'}
                                                        {else}
                                                        	{l s='Iniciar | Registrarme' mod='blockmyaccountfooter'}
                                                        {/if}
                                                    </a>
                                                </span>
                                               </span>


                                                {if $groups!=3 && $is_logged}
                                                <ul style="display: none;" class="submenu-container clearfix first-in-line-xs" style="left:150px;">
                                                    <li><span class="r-caret-up-menu-right"></span></li>
                                                    <li><ul>
                                                            <li><a href="{$base_uri}module/marketplace/editprofile" title="{l s='Manage my personal information' mod='blockmyaccountfooter'}" rel="nofollow">{l s='My profile' mod='blockmyaccountfooter'}</a></li>
                                                            {if $voucherAllowed}<li><a href="{$link->getPageLink('discount', true)|escape:'html':'UTF-8'}" title="{l s='My vouchers' mod='blockmyaccountfooter'}" rel="nofollow">{l s='My vouchers' mod='blockmyaccountfooter'}</a></li>{/if}

                                                            <li><a href="{$base_uri}module/marketplace/mporder" title="{l s='My orders' mod='blockmyaccountfooter'}" rel="nofollow">{l s='My orders' mod='blockmyaccountfooter'}</a></li>

                                                            <li><a href="{$base_uri}module/blockwishlist/mywishlist" title="{l s='Favorites' mod='blockmyaccountfooter'}" rel="nofollow">{l s='Favorites' mod='blockmyaccountfooter'}</a></li>

                                                            <li><a href="#" title="{l s='Settings' mod='blockmyaccountfooter'}" rel="nofollow">{l s='Settings' mod='blockmyaccountfooter'}</a></li>

                                                           {$HOOK_BLOCK_MY_ACCOUNT}
                                                            {if $is_logged}<li><a href="{$link->getPageLink('index')}?mylogout" title="{l s='Sign out' mod='blockmyaccountfooter'}" rel="nofollow">{l s='Sign out' mod='blockmyaccountfooter'}</a></li>{/if}


                                                        </ul></li>


                                                </ul>
                                                {/if}
                                                {if $groups==3 && $is_logged}
                                                <ul style="display: none;" class="submenu-container clearfix first-in-line-xs" style="text-align: center;">
                                                    <li><span class="r-caret-up-menu-right"></span></li>
                                                    <li><ul>
                                                            <li><a href="{$base_uri}module/marketplace/editprofile" title="{l s='Manage my personal information' mod='blockmyaccountfooter'}" rel="nofollow">{l s='My profile' mod='blockmyaccountfooter'}</a></li>
                                                            {if $voucherAllowed}<li><a href="{$link->getPageLink('discount', true)|escape:'html':'UTF-8'}" title="{l s='My vouchers' mod='blockmyaccountfooter'}" rel="nofollow">{l s='My vouchers' mod='blockmyaccountfooter'}</a></li>{/if}

                                                            <li><a href="{$base_uri}module/marketplace/mporder" title="{l s='My orders' mod='blockmyaccountfooter'}" rel="nofollow">{l s='My orders' mod='blockmyaccountfooter'}</a></li>

                                                            <li><a href="{$base_uri}module/marketplace/productlist" title="{l s='My products' mod='blockmyaccountfooter'}" rel="nofollow">{l s='My products' mod='blockmyaccountfooter'}</a></li>

                                                            <li><a href="{$link->getPageLink('history', true)|escape:'html':'UTF-8'}" title="{l s='My products' mod='blockmyaccountfooter'}" rel="nofollow">{l s='Sell history' mod='blockmyaccountfooter'}</a></li>

                                                            <li><a href="{$base_uri}module/blockwishlist/mywishlist" title="{l s='Pay details' mod='blockmyaccountfooter'}" rel="nofollow">{l s='Favorites' mod='blockmyaccountfooter'}</a></li>

                                                            <li><a href="#" title="{l s='Statistics' mod='blockmyaccountfooter'}" rel="nofollow">{l s='Statistics' mod='blockmyaccountfooter'}</a></li>

                                                            <li><a href="{$base_uri}module/marketplace/addproduct" title="{l s='New product'}" rel="nofollow">{l s='New product' }</a></li>


                                                           {$HOOK_BLOCK_MY_ACCOUNT}
                                                            {if $is_logged}<li><a href="{$link->getPageLink('index')}?mylogout" title="{l s='Sign out' mod='blockmyaccountfooter'}" rel="nofollow">{l s='Sign out' mod='blockmyaccountfooter'}</a></li>{/if}


                                                        </ul></li>


                                                </ul>                                                
                                                {/if}
                                            </li>

                                        </ul>
                                    </div>




							</div>
						</div>


					</div>

			</div>

                    {if $page_name =='index' && !$cookie->isLogged()}
                    <div class="seller_profile_header" style="background-color: black;margin-top: -51px; background-image: url({$img_dir}header.png);height: 150px;"></div>
                        <div style="text-align: center;">
                            <!-- TITULO -->
                        </div>
                    {/if}
                    {if (isset($mp_seller_info['id']) && !isset($product)) || (in_array($page_name,$pages))}
                    <div class="seller_profile_header" style="background-color: black;margin-top: -51px;">
                    {else}
                    <div class="seller_profile_header">
                    {/if}
                        {if (isset($mp_seller_info['id']) && !isset($product)) || (in_array($page_name,$pages))}

                            <div style="height: 320px;">

                            </div>

                        {else}
                            {*<img class="left_img" src="{$seller_img_path|escape:'html':'UTF-8'}" alt="Seller Image"/>*}
                            {if $in_seller_profile}
                                {if $no_shop_img == 0}
                                    <img class="shop_img" src="{$modules_dir|escape:'html':'UTF-8'}marketplace/views/img/shop_img/{$id_seller|escape:'html':'UTF-8'}-{$shop_name|escape:'html':'UTF-8'}.jpg" alt="{l s='Seller Image' mod='marketplace'}"/>
                                {else}
                                    <img class="shop_img" src="{$modules_dir|escape:'html':'UTF-8'}marketplace/views/img/shop_img/defaultshopimage.jpg" alt="Seller Image"/>
                                {/if}

                                {if isset($seller_img_path)}
                                    <img class="seller_img" src="{$seller_img_path|escape:'html':'UTF-8'}" alt="Seller Image"/>
                                {else}
                                    <img class="seller_img" src="{$modules_dir|escape:'htmlall':'UTF-8'}marketplace/views/img/seller_img/defaultimage.jpg" alt="Default Image"/>
                                {/if}
                            {/if}
                        {/if}
                    </div>

                                    {if !$is_logged && $page_name=='index'}
                                    <div class="title_home">
                                        COMUNIDAD AZUL
                                    </div>
                                    {/if}

                    {if (isset($mp_seller_info['id']) && !isset($product)) || (in_array($page_name,$pages))}
                    {if in_array($page_name,$pages)}
                    <div class="seller_header" >
                        <div  style="border:  1px solid white;">
                            <h1>{include file="$tpl_dir./$page_name.title.tpl"}</h1>
                        </div>
                    </div>                    
                    {/if}
                    {if !in_array($page_name,$pages)}
                    <div class="seller_header">
                        <div>
                            <h1>{$mp_seller_info['shop_name']}</h1>
                            <h2>{$mp_seller_info['seller_name']}</h2>
                        </div>
                    </div>
                    <div style="float: right; margin-right: 100px;margin-top: 50px;">
                        <span style="float: left; width:40px;margin-top: 5px;"><p
                                class="buttons_bottom_block no-print">
                            <a id="wishlist_button_nopop" href="#"
                               onclick="WishlistCart('wishlist_block_list', 'add', '3', $('#idCombination').val(), 1); return false;"
                               rel="nofollow" title="Add to my wishlist">
                                <img src="{$img_dir}/social2.png">
                            </a>
                        </p>
                        </span>                        
                    </div>
                    <div style="float: right;width: 10px;margin-right: -50px;margin-top: 50px;">
                                <div class="r_product_share_menu col-sm-2">

                                    <div class="sf-contener clearfix col-lg-12">


                                    <div class="sf-contener clearfix col-lg-12">


                                        <ul class="sf-menu clearfix menu-content sf-arrows">

                                            <li class="">
                                                       <span>
                                                           <!-- <span class="menu-img"></span> -->

                                                           <span><span><img class="" src="{$img_dir}/social.png" /></span></span>


                                                       </span>

                                                <ul style="display: none;" class="submenu-container clearfix first-in-line-xs">
                                                    <li><span class="r-caret-up-menu-share"></span></li>
                                                    <li><ul>
                                                            <li class="social-sharing" data-sharing-image="{$link->getImageLink($product.link_rewrite, $product.id_image, 'home_default')|escape:'html':'UTF-8'}" data-sharing-name="{$product.name}" data-sharing_url="{$product.link|escape:'html'}" data-type="pinterest">
                                                                <a href="javascript:;">
                                                                    <i class="icon-pinterest"></i>
                                                                    {l s="Pinterest" mod='socialsharing'}
                                                                </a>
                                                            </li>
                                                            <li class="social-sharing" data-sharing-name="{$product.name}" data-sharing_url="{$product.link|escape:'html'}" data-type="google-plus">
                                                                <a href="javascript:;">
                                                                    <i class="icon-google-plus"></i>
                                                                    {l s="Google+" mod='socialsharing'}
                                                                </a>
                                                            </li>
                                                            <li class="social-sharing" data-sharing-name="{$product.name}" data-sharing_url="{$product.link|escape:'html'}" data-type="facebook">
                                                                <a href="javascript:;">
                                                                    <i class="icon-facebook"></i>
                                                                    {l s="Share" mod='socialsharing'}
                                                                </a>
                                                            </li>
                                                            <li class="social-sharing" data-sharing-name="{$product.name}" data-sharing_url="{$product.link|escape:'html'}" data-type="twitter">
                                                                <a href="javascript:;">
                                                                    <i class="icon-twitter"></i>
                                                                    {l s="Tweet" mod='socialsharing'}
                                                                </a>
                                                            </li>





                                                        </ul></li>


                                                </ul>
                                            </li>


                                        </ul>
                                    </div>
                                    </div>


                                </div>                      
                    </div>
                    {/if}

                    <div class="seller_image">
                        {if isset($seller_img_path)}
                            <img class="seller_img" src="{$seller_img_path|escape:'html':'UTF-8'}" alt="Seller Image" style="border-radius: 20px;" />
                        {else}
                            <img class="seller_img" src="{$modules_dir|escape:'htmlall':'UTF-8'}marketplace/views/img/seller_img/defaultimage.jpg" alt
="Default Image" style="border-radius: 20px;'" />
                        {/if}                            
                    </div>

                    <div class="edit">
                        <a {if !$profile && !in_array($page_name,$pages)} {else} style="visibility: hidden;;" {/if}href="{$base_uri}module/marketplace/editprofile?edit=true"><img src="{$img_dir}edit.png" /></a>
                    </div>

                    <div class="col-ms-2 col-xs-2 col-lg-2">
                    
                    </div>
                    <div class="col-ms-10 col-xs-10 col-lg-10">
                        <div style="margin: -20px 45px 0px 45px;">
                        {if isset($mp_seller_info['id']) && !isset($product) && !$edit}
                            {html_entity_decode($mp_seller_info['about_shop'])}
                        {/if}    
                        </div>
                    </div>
            
                    <div class="col-ms-2 col-xs-2 col-lg-2">

                        <div class="social-icons">
                            Social Networks  
                        </div>
                        <div class="social-icons">
                            <img src="{$img_dir}facebook.png" />
                            <img src="{$img_dir}social3.png" />
                            <img src="{$img_dir}twitter.png" />
                            <img src="{$img_dir}pinterest.png" />
                        </div>
                    
                        <br />

                        <div class="social-icons">
                            Prix
                        </div>
                        <div class="social-icons">
                            <img class="rate" src="{$img_dir}mandala-color.jpg" />
                            <img class="rate" src="{$img_dir}mandala-color.jpg" />
                            <img class="rate" src="{$img_dir}mandala-color.jpg" />
                            <img class="rate" src="{$img_dir}mandala-color.jpg" />
                        </div>

                        <div class="social-icons">
                            Qualited
                        </div>
                        <div class="social-icons">
                            <img class="rate" src="{$img_dir}mandala-color.jpg" />
                            <img class="rate" src="{$img_dir}mandala-color.jpg" />
                            <img class="rate" src="{$img_dir}mandala-color.jpg" />
                            <img class="rate" src="{$img_dir}mandala-color.jpg" />
                        </div>

                    </div> 

                    {if ( !$edit && !in_array($page_name,$pages) )}
                    <div class="col-ms-12 col-xs-12 col-lg-12" style="margin-top: 200px;">
                        <section class="variable slider">

                            {foreach from=$products_seller item=product name=products}
                            <div>
                              
                                <div class="tab-content">   
                                            <!-- Products list -->
                                                <ul id="blocknewproducts" class="col-xs-3 col-sm-3 col-md-3 product_list grid row blocknewproducts tab-pane active">
                                                
                                                    <li class="ajax_block_product col-xs-12 col-sm-12 col-md-12 first-in-line first-item-of-tablet-line first-item-of-mobile-line" style="height: 400px; margin-bottom: 0px;">
                                                    <div class="col-ms-12 col-xs-12 col-lg-12" style="position: absolute; z-index: 9999; left:-10px; top: 10px;">
                                                        {if !$profile}
                                                        <a href="{$base_uri}module/marketplace/productupdate?id={$product.id}&editproduct=1"><img style="width:auto !important;margin: auto;float: right;" src="{$img_dir}edit.png" /></a>
                                                        {/if}
                                                    </div>                                                                                                                
                                                    <div class="product-container" itemscope="" itemtype="https://schema.org/Product">
                                                        <div class="left-block" style="background-image: url({$product.logo})">

                                                            <div class="product-image-container">
                                                                <a class="product_img_link" href="#" title="Producrto D" itemprop="url">
                                                                    <img style="visibility: hidden;" class="replace-2x img-responsive" src="{$product.logo}" alt="Producrto D" title="Producrto D" width="250" height="250" itemprop="image">
                                                                </a>
                                                                                                    <div class="quick-view-wrapper-mobile">
                                                                    <a class="quick-view-mobile" href="#" rel="#">
                                                                        <i class="icon-eye-open"></i>
                                                                    </a>
                                                                </div>
                                                                <a class="quick-view" href="#" rel="#">
                                                                    <span>Quick view</span>
                                                                </a>
                                                                                                                                    <div class="content_price" itemprop="offers" itemscope="" itemtype="https://schema.org/Offer">
                                                                                                                    <span itemprop="price" class="price product-price">
                                                                                
                                                                                {$product.price}
                                                                                                                          </span>
                                                                            <meta itemprop="priceCurrency" content="USD">
                                                                                                                                                                        <span class="unvisible">
                                                                                                                                                <link itemprop="availability" href="https://schema.org/InStock">In Stock                                                                                                    </span>
                                                                                                                        
                                                                            
                                                                                                            </div>
                                                                                                                                    <a class="new-box" href="http://localhost/prestashop_1.6.1.6_es/prestashop/home/14-producrto-d.html">
                                                                        <span class="new-label">New</span>
                                                                    </a>
                                                                                                                            </div>
                                                                                        
                                                        </div>
                                                        <div class="right-block margin-top-0">
                                                            <h5 itemprop="name">
                                <a class="product-name" href="{$product.link|escape:'html':'UTF-8'}" title="{$product.name|escape:'html':'UTF-8'}" itemprop="url" >
                                    {$product.product_name|truncate:45:'...'|escape:'html':'UTF-8'}
                                </a>
                                                                                            </h5>
                                                                                                                    <p class="product-desc" itemprop="description">
                                                                sadfasdf
                                                            </p>
                                                                                    
                                                            <div>
                                                                <div class="col-sm-2 leftl10">
                                                                    <span style="float: left; width:40px;margin-top: 5px;"><p class="buttons_bottom_block no-print">
                                                                        <a id="wishlist_button_nopop" href="#" onclick="WishlistCart('wishlist_block_list', 'add', '3', $('#idCombination').val(), 1); return false;" rel="nofollow" title="Add to my wishlist">
                                                                            <img class="social2" src="http://localhost/prestashop_1.6.1.6_es/prestashop/themes/rem-theme/img//social2.png" style="margin-left:10px;">
                                                                        </a>
                                                                    </p>
                                                                    </span>                 
                                                                </div>  

                                                                <div class="r_product_share_menu col-sm-2">

                                                                    <div class="sf-contener clearfix col-lg-12">


                                                                        <ul class="sf-menu clearfix menu-content sf-arrows">    

                                                                            <li class="">
                                                                                       <span>
                                                                                           <!-- <span class="menu-img"></span> -->

                                                                                           <span><span><img class="social" style="margin-left:10px;" src="{$img_dir}/social.png"></span></span>
                                                                                       </span>

                                                                                <ul style="display: none;" class="submenu-container clearfix first-in-line-xs">
                                                                                    <li><span class="r-caret-up-menu-share"></span></li>
                                                                                    <li><ul style="display: none;">
                                                                                            <li class="social-sharing" data-sharing-image="http://localhost/prestashop_1.6.1.6_es/prestashop/33-home_default/producrto-d.jpg" data-sharing-name="Producrto D" data-sharing_url="http://localhost/prestashop_1.6.1.6_es/prestashop/home/14-producrto-d.html" data-type="pinterest">
                                                                                                <a href="javascript:;">
                                                                                                    <i class="icon-pinterest"></i>
                                                                                                    Pinterest
                                                                                                </a>
                                                                                            </li>
                                                                                            <li class="social-sharing" data-sharing-name="Producrto D" data-sharing_url="http://localhost/prestashop_1.6.1.6_es/prestashop/home/14-producrto-d.html" data-type="google-plus">
                                                                                                <a href="javascript:;">
                                                                                                    <i class="icon-google-plus"></i>
                                                                                                    Google+
                                                                                                </a>
                                                                                            </li>
                                                                                            <li class="social-sharing" data-sharing-name="Producrto D" data-sharing_url="http://localhost/prestashop_1.6.1.6_es/prestashop/home/14-producrto-d.html" data-type="facebook">
                                                                                                <a href="javascript:;">
                                                                                                    <i class="icon-facebook"></i>
                                                                                                    Share
                                                                                                </a>
                                                                                            </li>
                                                                                            <li class="social-sharing" data-sharing-name="Producrto D" data-sharing_url="http://localhost/prestashop_1.6.1.6_es/prestashop/home/14-producrto-d.html" data-type="twitter">
                                                                                                <a href="javascript:;">
                                                                                                    <i class="icon-twitter"></i>
                                                                                                    Tweet
                                                                                                </a>
                                                                                            </li>





                                                                                        </ul></li>


                                                                                </ul>
                                                                            </li>


                                                                        </ul>
                                                                    </div>


                                                                </div>

                                                                <div class="content_price">
                                                                                                    
                                                                    <span class="price product-price">
                                                                        {$price}                                   </span>
                                                                                                        
                                                                    
                                                                    
                                                                                            </div>

                                                            <div class="car_and_supplier">
                                                                <div class="r-seller-link" style="margin-top:6px; color:#ab9898;">

                                                                    {$mp_seller_info['seller_name']}
                                                                    
                                                                </div>

                                                                      
                                                                            <span style="visibility: hidden;" class="product-cart"></span>
                                                                        </a>
                                                                                                                                </div>
                                                                                        <div class="button-container" style="display: none;">

                                                                <a class="button lnk_view btn btn-default" href="http://localhost/prestashop_1.6.1.6_es/prestashop/home/14-producrto-d.html" title="View">
                                                                    <span>More</span>
                                                                </a>
                                                            </div>
                                                                                        <div class="product-flags">
                                                                                                                                                                                                </div>
                                                                                                                                <span class="availability">
                                                                                                                   
                                                                                                            </span>
                                                                                                                    </div>
                                                                            </div><!-- .product-container> -->
                                                </div></li>
                                                
                                                                        
                                                                    </ul>
                                        
                                                <script>
                                            $(document).ready(function(){
                                                $('li.social-sharing').on('click', function(){
                                                    type = $(this).attr('data-type');
                                                    sharing_name = $(this).attr('data-sharing-name');
                                                    sharing_url = $(this).attr('data-sharing_url');
                                                    if (type.length)
                                                    {
                                                        switch(type)
                                                        {
                                                            case 'twitter':
                                                                window.open('https://twitter.com/intent/tweet?text=' + sharing_name + ' ' + sharing_url, 'sharertwt', 'toolbar=0,status=0,width=640,height=445');
                                                                break;
                                                            case 'facebook':
                                                                window.open('http://www.facebook.com/sharer.php?u=' + sharing_url, 'sharer', 'toolbar=0,status=0,width=660,height=445');
                                                                break;
                                                            case 'google-plus':
                                                                window.open('https://plus.google.com/share?url=' + sharing_url, 'sharer', 'toolbar=0,status=0,width=660,height=445');
                                                                break;
                                                            case 'pinterest':
                                                                var img_url = $(this).attr('data-sharing-image');
                                                                if (typeof $("#bigpic").attr('src') != 'undefined' && $("#bigpic").attr('src') != '') {
                                                                    img_url = $("#bigpic").attr('src');
                                                                }
                                                                window.open('http://www.pinterest.com/pin/create/button/?media=' + img_url + '&url=' + sharing_url, 'sharerpinterest', 'toolbar=0,status=0,width=660,height=445');
                                                                break;
                                                        }
                                                    }
                                                });
                                            });

                                            $('#blockbestsellers').hide();
                                        </script>
                                        

                                </div>



                            </div>
                            {/foreach}

                        </section> 
                    </div>
                    {/if}
                {/if}

                </header>

            {if ( $edit || in_array($page_name,$pages) )}
                <div class="col-ms-2 col-xs-2 col-lg-2"></div>
                <div class="col-ms-10 col-xs-10 col-lg-10">
            {/if}    
            <div class="columns-container">
                <div id="columns" class="container" {if $page_name=='index' && !$cookie->isLogged()} style="padding-top:0px;margin-top:-35px;" {/if} >


					{if $page_name !='index' && $page_name !='pagenotfound' && !$in_seller_profile}
						{include file="$tpl_dir./breadcrumb.tpl"}
					{/if}

					<div id="slider_row" class="row">
						{capture name='displayTopColumn'}{hook h='displayTopColumn'}{/capture}
						{if $smarty.capture.displayTopColumn==null}
							<div id="top_column" class="center_column col-xs-12 col-sm-12">{$smarty.capture.displayTopColumn}</div>
						{/if}
					</div>

					<div class="row">
						{if isset($left_column_size) && !empty($left_column_size)}
						<div id="left_column" class="column col-xs-12 col-sm-{$left_column_size|intval}">{$HOOK_LEFT_COLUMN}</div>
						{/if}
						{if isset($left_column_size) && isset($right_column_size)}{assign var='cols' value=(12 - $left_column_size - $right_column_size)}{else}{assign var='cols' value=12}{/if}
						<div id="center_column" class="center_column col-xs-12 col-sm-{$cols|intval}">
	{/if}

  <script src="{$js_dir}jquery-2.1.4.min.js" type="text/javascript"></script>  
  <script src="{$js_dir}slick.js" type="text/javascript" charset="utf-8"></script>
  <script type="text/javascript">
    $(document).on('ready', function() {
      $(".regular").slick({
        dots: true,
        infinite: true,
        slidesToShow: 3,
        slidesToScroll: 3
      });
      $(".center").slick({
        dots: false,
        infinite: true,
        centerMode: false,
        slidesToShow: 4,
        slidesToScroll: 3
      });
      $(".variable").slick({
        dots: false,
        infinite: false,
        variableWidth: true,
        arrows: true,

          nextArrow: '<img src="{$img_dir}d.png" class="slick-next slick-arrow slick-disabled" aria-label="Previous" role="button" aria-disabled="true" />',
          prevArrow: '<img src="{$img_dir}i.png" data-role="none" class="slick-prev slick-arrow slick-disabled" aria-label="Previous" role="button" aria-disabled="true"/>'

  // nextArrow: '<button type="button" data-role="none" class="slick-next slick-arrow slick-disabled" aria-label="Previous" role="button" aria-disabled="true" style="display: block;color:black; background-color:black;">Next</button>',
  // prevArrow: '<button type="button" data-role="none" class="slick-prev slick-arrow slick-disabled" aria-label="Previous" role="button" aria-disabled="true" style="display: block;color:black; background-color:black;">Previous</button>'       
      });
    });
  </script>
    <script type="text/javascript">
        $(document).ready(function(){
            $('#block_top_right_menu > ul > li > ul').css('left','150px');
            $('#blocknewproducts').show();
            $('.slider').css('width','100% !important');
            {if isset($mp_seller_info['id'])}
            //$('.columns-container').css('display','none');  
            $('.slick-dots').hide();
            {/if}
        })
    </script>
