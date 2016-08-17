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
{if $page_name =='index'}
	{if $cookie->isLogged()}
		{if isset($products) && $products}
			{*define number of products per line in other page for desktop*}
			{if $page_name !='index' && $page_name !='product'}
				{assign var='nbItemsPerLine' value=3}
				{assign var='nbItemsPerLineTablet' value=2}
				{assign var='nbItemsPerLineMobile' value=3}
			{else}
				{assign var='nbItemsPerLine' value=4}
				{assign var='nbItemsPerLineTablet' value=3}
				{assign var='nbItemsPerLineMobile' value=2}
			{/if}
			{*define numbers of product per line in other page for tablet*}
			{assign var='nbLi' value=$products|@count}
			{assign var='conteo' value=0}
			{math equation="nbLi/nbItemsPerLine" nbLi=$nbLi nbItemsPerLine=$nbItemsPerLine assign=nbLines}
			{math equation="nbLi/nbItemsPerLineTablet" nbLi=$nbLi nbItemsPerLineTablet=$nbItemsPerLineTablet assign=nbLinesTablet}
			<!-- Products list -->
			{assign var='i' value=0}
			{assign var='j' value=0}
			<ul{if isset($id) && $id} id="{$id}"{/if} class="col-xs-3 col-sm-3 col-md-3 product_list grid row{if isset($class) && $class} {$class}{/if}">
			{foreach from=$products item=product name=products}
			{if $j==$i}
				{math equation="(total%perLine)" total=$smarty.foreach.products.total perLine=$nbItemsPerLine assign=totModulo}
				{math equation="(total%perLineT)" total=$smarty.foreach.products.total perLineT=$nbItemsPerLineTablet assign=totModuloTablet}
				{math equation="(total%perLineT)" total=$smarty.foreach.products.total perLineT=$nbItemsPerLineMobile assign=totModuloMobile}
				{if $totModulo == 0}{assign var='totModulo' value=$nbItemsPerLine}{/if}
				{if $totModuloTablet == 0}{assign var='totModuloTablet' value=$nbItemsPerLineTablet}{/if}
				{if $totModuloMobile == 0}{assign var='totModuloMobile' value=$nbItemsPerLineMobile}{/if}
				{assign var=i value=$i+4}
				<li class="ajax_block_product{if $page_name == 'index' || $page_name == 'product'} col-xs-12 col-sm-12 col-md-12{else} col-xs-12 col-sm-12 col-md-4{/if}{if $smarty.foreach.products.iteration%$nbItemsPerLine == 0} last-in-line{elseif $smarty.foreach.products.iteration%$nbItemsPerLine == 1} first-in-line{/if}{if $smarty.foreach.products.iteration > ($smarty.foreach.products.total - $totModulo)} last-line{/if}{if $smarty.foreach.products.iteration%$nbItemsPerLineTablet == 0} last-item-of-tablet-line{elseif $smarty.foreach.products.iteration%$nbItemsPerLineTablet == 1} first-item-of-tablet-line{/if}{if $smarty.foreach.products.iteration%$nbItemsPerLineMobile == 0} last-item-of-mobile-line{elseif $smarty.foreach.products.iteration%$nbItemsPerLineMobile == 1} first-item-of-mobile-line{/if}{if $smarty.foreach.products.iteration > ($smarty.foreach.products.total - $totModuloMobile)} last-mobile-line{/if}">
					<div class="product-container" itemscope itemtype="https://schema.org/Product">
						<div class="left-block" style="background-image: url({$link->getImageLink($product.link_rewrite, $product.id_image, 'home_default')|escape:'html':'UTF-8'});">
							<div class="product-image-container">
								<a class="product_img_link" href="{$product.link|escape:'html':'UTF-8'}" title="{$product.name|escape:'html':'UTF-8'}" itemprop="url">
									<img style="visibility: hidden;" class="replace-2x img-responsive" src="{$link->getImageLink($product.link_rewrite, $product.id_image, 'home_default')|escape:'html':'UTF-8'}" alt="{if !empty($product.legend)}{$product.legend|escape:'html':'UTF-8'}{else}{$product.name|escape:'html':'UTF-8'}{/if}" title="{if !empty($product.legend)}{$product.legend|escape:'html':'UTF-8'}{else}{$product.name|escape:'html':'UTF-8'}{/if}" {if isset($homeSize)} width="{$homeSize.width}" height="{$homeSize.height}"{/if} itemprop="image" />
								</a>
								{if isset($quick_view) && $quick_view}
									<div class="quick-view-wrapper-mobile">
									<a class="quick-view-mobile" href="{$product.link|escape:'html':'UTF-8'}" rel="{$product.link|escape:'html':'UTF-8'}">
										<i class="icon-eye-open"></i>
									</a>
								</div>
								<a class="quick-view" href="{$product.link|escape:'html':'UTF-8'}" rel="{$product.link|escape:'html':'UTF-8'}">
									<span>{l s='Quick view'}</span>
								</a>
								{/if}
								{if (!$PS_CATALOG_MODE && ((isset($product.show_price) && $product.show_price) || (isset($product.available_for_order) && $product.available_for_order)))}
									<div class="content_price" itemprop="offers" itemscope itemtype="https://schema.org/Offer">
										{if isset($product.show_price) && $product.show_price && !isset($restricted_country_mode)}
											<span itemprop="price" class="price product-price">
												{hook h="displayProductPriceBlock" product=$product type="before_price"}
												{if !$priceDisplay}{convertPrice price=$product.price}{else}{convertPrice price=$product.price_tax_exc}{/if}
											</span>
											<meta itemprop="priceCurrency" content="{$currency->iso_code}" />
											{if $product.price_without_reduction > 0 && isset($product.specific_prices) && $product.specific_prices && isset($product.specific_prices.reduction) && $product.specific_prices.reduction > 0}
												{hook h="displayProductPriceBlock" product=$product type="old_price"}
												<span class="old-price product-price">
													{displayWtPrice p=$product.price_without_reduction}
												</span>
												{if $product.specific_prices.reduction_type == 'percentage'}
													<span class="price-percent-reduction">-{$product.specific_prices.reduction * 100}%</span>
												{/if}
											{/if}
											{if $PS_STOCK_MANAGEMENT && isset($product.available_for_order) && $product.available_for_order && !isset($restricted_country_mode)}
												<span class="unvisible">
													{if ($product.allow_oosp || $product.quantity > 0)}
															<link itemprop="availability" href="https://schema.org/InStock" />{if $product.quantity <= 0}{if $product.allow_oosp}{if isset($product.available_later) && $product.available_later}{$product.available_later}{else}{l s='In Stock'}{/if}{/if}{else}{if isset($product.available_now) && $product.available_now}{$product.available_now}{else}{l s='In Stock'}{/if}{/if}
													{elseif (isset($product.quantity_all_versions) && $product.quantity_all_versions > 0)}
															<link itemprop="availability" href="https://schema.org/LimitedAvailability" />{l s='Product available with different options'}

													{else}
															<link itemprop="availability" href="https://schema.org/OutOfStock" />{l s='Out of stock'}
													{/if}
												</span>
											{/if}
											{hook h="displayProductPriceBlock" product=$product type="price"}
											{hook h="displayProductPriceBlock" product=$product type="unit_price"}
										{/if}
									</div>
								{/if}
								{if isset($product.new) && $product.new == 1}
									<a class="new-box" href="{$product.link|escape:'html':'UTF-8'}">
										<span class="new-label">{l s='New'}</span>
									</a>
								{/if}
								{if isset($product.on_sale) && $product.on_sale && isset($product.show_price) && $product.show_price && !$PS_CATALOG_MODE}
									<a class="sale-box" href="{$product.link|escape:'html':'UTF-8'}">
										<span class="sale-label">{l s='Sale!'}</span>
									</a>
								{/if}
							</div>
							{if isset($product.is_virtual) && !$product.is_virtual}{hook h="displayProductDeliveryTime" product=$product}{/if}
							{hook h="displayProductPriceBlock" product=$product type="weight"}
						</div>
						<div class="right-block margin-top-0">
							<h5 itemprop="name">
								{if isset($product.pack_quantity) && $product.pack_quantity}{$product.pack_quantity|intval|cat:' x '}{/if}
								<a class="product-name" href="{$product.link|escape:'html':'UTF-8'}" title="{$product.name|escape:'html':'UTF-8'}" itemprop="url" >
									{$product.name|truncate:45:'...'|escape:'html':'UTF-8'}
								</a>
							</h5>
							{capture name='displayProductListReviews'}{hook h='displayProductListReviews' product=$product}{/capture}
							{if $smarty.capture.displayProductListReviews}
								<div class="hook-reviews">
								{hook h='displayProductListReviews' product=$product}
								</div>
							{/if}
							<p class="product-desc" itemprop="description">
								{$product.description_short|strip_tags:'UTF-8'|truncate:360:'...'}
							</p>
							{if (!$PS_CATALOG_MODE AND ((isset($product.show_price) && $product.show_price) || (isset($product.available_for_order) && $product.available_for_order)))}
						
							<div>
								<div class="col-sm-2 leftl10">
									<span style="float: left; width:40px;margin-top: 7px;"><p class="buttons_bottom_block no-print">
										<a id="wishlist_button_nopop" href="#" onclick="WishlistCart('wishlist_block_list', 'add', '3', $('#idCombination').val(), 1); return false;" rel="nofollow" title="Add to my wishlist">
											<img class="social2" src="{$img_dir}/social2.png" />
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

		                                                   <span><span><img class="social" src="{$img_dir}/social.png" /></span></span>


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

		                        <div class="content_price">
								{if isset($product.show_price) && $product.show_price && !isset($restricted_country_mode)}
									{hook h="displayProductPriceBlock" product=$product type='before_price'}
									<span class="price product-price">
										{if !$priceDisplay}{convertPrice price=$product.price}{else}{convertPrice price=$product.price_tax_exc}{/if}
									</span>
									{if $product.price_without_reduction > 0 && isset($product.specific_prices) && $product.specific_prices && isset($product.specific_prices.reduction) && $product.specific_prices.reduction > 0}
										{hook h="displayProductPriceBlock" product=$product type="old_price"}
										<span class="old-price product-price">
											{displayWtPrice p=$product.price_without_reduction}
										</span>
										{hook h="displayProductPriceBlock" id_product=$product.id_product type="old_price"}
										{if $product.specific_prices.reduction_type == 'percentage'}
											<span class="price-percent-reduction">-{$product.specific_prices.reduction * 100}%</span>
										{/if}
									{/if}
									{hook h="displayProductPriceBlock" product=$product type="price"}
									{hook h="displayProductPriceBlock" product=$product type="unit_price"}
									{hook h="displayProductPriceBlock" product=$product type='after_price'}
								{/if}
							</div>

		                    <div class="car_and_supplier">
		                        <div class="r-seller-link">
		                        	<img src="{$base_uri}modules/marketplace/views/img/shop_img/{$seller_product[$product.name][0]}" width="15" />
		                        	{$seller_product[$product.name][1]}
		                            {hook h='displayProductListSeller' id_product=$product.id_product|escape:'html':'UTF-8'}
		                        </div>

		                        {if ($product.id_product_attribute == 0 || (isset($add_prod_display) && ($add_prod_display == 1))) && $product.available_for_order && !isset($restricted_country_mode) && $product.customizable != 2 && !$PS_CATALOG_MODE}
		                            {if (!isset($product.customization_required) || !$product.customization_required) && ($product.allow_oosp || $product.quantity > 0)}
		                                {capture}add=1&amp;id_product={$product.id_product|intval}{if isset($product.id_product_attribute) && $product.id_product_attribute}&amp;ipa={$product.id_product_attribute|intval}{/if}{if isset($static_token)}&amp;token={$static_token}{/if}{/capture}
		                                <a class="ajax_add_to_cart_button" href="{$link->getPageLink('cart', true, NULL, $smarty.capture.default, false)|escape:'html':'UTF-8'}" rel="nofollow" title="{l s='Add to cart'}" data-id-product-attribute="{$product.id_product_attribute|intval}" data-id-product="{$product.id_product|intval}" data-minimal_quantity="{if isset($product.product_attribute_minimal_quantity) && $product.product_attribute_minimal_quantity >= 1}{$product.product_attribute_minimal_quantity|intval}{else}{$product.minimal_quantity|intval}{/if}">
		                                    <span class="product-cart"></span>
		                                </a>
		                            {else}
		                                <span class="ajax_add_to_cart_button disabled">
											<span class="product-cart"></span>
										</span>
		                            {/if}
		                        {/if}
		                    </div>
							{/if}
							<div class="button-container">

								<a class="button lnk_view btn btn-default" href="{$product.link|escape:'html':'UTF-8'}" title="{l s='View'}">
									<span>{if (isset($product.customization_required) && $product.customization_required)}{l s='Customize'}{else}{l s='More'}{/if}</span>
								</a>
							</div>
							{if isset($product.color_list)}
								<div class="color-list-container">{$product.color_list}</div>
							{/if}
							<div class="product-flags">
								{if (!$PS_CATALOG_MODE AND ((isset($product.show_price) && $product.show_price) || (isset($product.available_for_order) && $product.available_for_order)))}
									{if isset($product.online_only) && $product.online_only}
										<span class="online_only">{l s='Online only'}</span>
									{/if}
								{/if}
								{if isset($product.on_sale) && $product.on_sale && isset($product.show_price) && $product.show_price && !$PS_CATALOG_MODE}
									{elseif isset($product.reduction) && $product.reduction && isset($product.show_price) && $product.show_price && !$PS_CATALOG_MODE}
										<span class="discount">{l s='Reduced price!'}</span>
									{/if}
							</div>
							{if (!$PS_CATALOG_MODE && $PS_STOCK_MANAGEMENT && ((isset($product.show_price) && $product.show_price) || (isset($product.available_for_order) && $product.available_for_order)))}
								{if isset($product.available_for_order) && $product.available_for_order && !isset($restricted_country_mode)}
									<span class="availability">
										{if ($product.allow_oosp || $product.quantity > 0)}
											<span class="{if $product.quantity <= 0 && isset($product.allow_oosp) && !$product.allow_oosp} label-danger{elseif $product.quantity <= 0} label-warning{else} label-success{/if}">
												{if $product.quantity <= 0}{if $product.allow_oosp}{if isset($product.available_later) && $product.available_later}{$product.available_later}{else}{l s='In Stock'}{/if}{else}{l s='Out of stock'}{/if}{else}{if isset($product.available_now) && $product.available_now}{$product.available_now}{else}{l s='In Stock'}{/if}{/if}
											</span>
										{elseif (isset($product.quantity_all_versions) && $product.quantity_all_versions > 0)}
											<span class="label-warning">
												{l s='Product available with different options'}
											</span>
										{else}
											<span class="label-danger">
												{l s='Out of stock'}
											</span>
										{/if}
									</span>
								{/if}
							{/if}
						</div>
						{if $page_name != 'index'}
							<div class="functional-buttons clearfix">
								{hook h='displayProductListFunctionalButtons' product=$product}
								{if isset($comparator_max_item) && $comparator_max_item}
									<div class="compare">
										<a class="add_to_compare" href="{$product.link|escape:'html':'UTF-8'}" data-id-product="{$product.id_product}">{l s='Add to Compare'}</a>
									</div>
								{/if}
							</div>
						{/if}
					</div><!-- .product-container> -->
				</li>
			{/if}	
			{assign var='j' value=$j+1}
			{/foreach}
			</ul>


			{assign var='i' value=1}
			{assign var='j' value=0}
			<ul{if isset($id) && $id} id="{$id}"{/if} class="col-xs-3 col-sm-3 col-md-3 product_list grid row{if isset($class) && $class} {$class}{/if}">
			{foreach from=$products item=product name=products}
			{if $j==$i}
				{math equation="(total%perLine)" total=$smarty.foreach.products.total perLine=$nbItemsPerLine assign=totModulo}
				{math equation="(total%perLineT)" total=$smarty.foreach.products.total perLineT=$nbItemsPerLineTablet assign=totModuloTablet}
				{math equation="(total%perLineT)" total=$smarty.foreach.products.total perLineT=$nbItemsPerLineMobile assign=totModuloMobile}
				{if $totModulo == 0}{assign var='totModulo' value=$nbItemsPerLine}{/if}
				{if $totModuloTablet == 0}{assign var='totModuloTablet' value=$nbItemsPerLineTablet}{/if}
				{if $totModuloMobile == 0}{assign var='totModuloMobile' value=$nbItemsPerLineMobile}{/if}
				{assign var=i value=$i+4}
				<li class="ajax_block_product{if $page_name == 'index' || $page_name == 'product'} col-xs-12 col-sm-12 col-md-12{else} col-xs-12 col-sm-12 col-md-4{/if}{if $smarty.foreach.products.iteration%$nbItemsPerLine == 0} last-in-line{elseif $smarty.foreach.products.iteration%$nbItemsPerLine == 1} first-in-line{/if}{if  $j==($i+4) && $smarty.foreach.products.iteration > ($smarty.foreach.products.total - $totModulo)} last-line{/if}{if $smarty.foreach.products.iteration%$nbItemsPerLineTablet == 0} last-item-of-tablet-line{elseif $smarty.foreach.products.iteration%$nbItemsPerLineTablet == 1} first-item-of-tablet-line{/if}{if $smarty.foreach.products.iteration%$nbItemsPerLineMobile == 0} last-item-of-mobile-line{elseif $smarty.foreach.products.iteration%$nbItemsPerLineMobile == 1} first-item-of-mobile-line{/if}{if  $j==($i+4) || $smarty.foreach.products.iteration > ($smarty.foreach.products.total - $totModuloMobile)} last-mobile-line{/if}">
					<div class="product-container" itemscope itemtype="https://schema.org/Product">
						<div class="left-block" style="background-image: url({$link->getImageLink($product.link_rewrite, $product.id_image, 'home_default')|escape:'html':'UTF-8'});">
							<div class="product-image-container">
								<a class="product_img_link" href="{$product.link|escape:'html':'UTF-8'}" title="{$product.name|escape:'html':'UTF-8'}" itemprop="url">
									<img style="visibility: hidden;" class="replace-2x img-responsive" src="{$link->getImageLink($product.link_rewrite, $product.id_image, 'home_default')|escape:'html':'UTF-8'}" alt="{if !empty($product.legend)}{$product.legend|escape:'html':'UTF-8'}{else}{$product.name|escape:'html':'UTF-8'}{/if}" title="{if !empty($product.legend)}{$product.legend|escape:'html':'UTF-8'}{else}{$product.name|escape:'html':'UTF-8'}{/if}" {if isset($homeSize)} width="{$homeSize.width}" height="{$homeSize.height}"{/if} itemprop="image" />
								</a>
								{if isset($quick_view) && $quick_view}
									<div class="quick-view-wrapper-mobile">
									<a class="quick-view-mobile" href="{$product.link|escape:'html':'UTF-8'}" rel="{$product.link|escape:'html':'UTF-8'}">
										<i class="icon-eye-open"></i>
									</a>
								</div>
								<a class="quick-view" href="{$product.link|escape:'html':'UTF-8'}" rel="{$product.link|escape:'html':'UTF-8'}">
									<span>{l s='Quick view'}</span>
								</a>
								{/if}
								{if (!$PS_CATALOG_MODE && ((isset($product.show_price) && $product.show_price) || (isset($product.available_for_order) && $product.available_for_order)))}
									<div class="content_price" itemprop="offers" itemscope itemtype="https://schema.org/Offer">
										{if isset($product.show_price) && $product.show_price && !isset($restricted_country_mode)}
											<span itemprop="price" class="price product-price">
												{hook h="displayProductPriceBlock" product=$product type="before_price"}
												{if !$priceDisplay}{convertPrice price=$product.price}{else}{convertPrice price=$product.price_tax_exc}{/if}
											</span>
											<meta itemprop="priceCurrency" content="{$currency->iso_code}" />
											{if $product.price_without_reduction > 0 && isset($product.specific_prices) && $product.specific_prices && isset($product.specific_prices.reduction) && $product.specific_prices.reduction > 0}
												{hook h="displayProductPriceBlock" product=$product type="old_price"}
												<span class="old-price product-price">
													{displayWtPrice p=$product.price_without_reduction}
												</span>
												{if $product.specific_prices.reduction_type == 'percentage'}
													<span class="price-percent-reduction">-{$product.specific_prices.reduction * 100}%</span>
												{/if}
											{/if}
											{if $PS_STOCK_MANAGEMENT && isset($product.available_for_order) && $product.available_for_order && !isset($restricted_country_mode)}
												<span class="unvisible">
													{if ($product.allow_oosp || $product.quantity > 0)}
															<link itemprop="availability" href="https://schema.org/InStock" />{if $product.quantity <= 0}{if $product.allow_oosp}{if isset($product.available_later) && $product.available_later}{$product.available_later}{else}{l s='In Stock'}{/if}{/if}{else}{if isset($product.available_now) && $product.available_now}{$product.available_now}{else}{l s='In Stock'}{/if}{/if}
													{elseif (isset($product.quantity_all_versions) && $product.quantity_all_versions > 0)}
															<link itemprop="availability" href="https://schema.org/LimitedAvailability" />{l s='Product available with different options'}

													{else}
															<link itemprop="availability" href="https://schema.org/OutOfStock" />{l s='Out of stock'}
													{/if}
												</span>
											{/if}
											{hook h="displayProductPriceBlock" product=$product type="price"}
											{hook h="displayProductPriceBlock" product=$product type="unit_price"}
										{/if}
									</div>
								{/if}
								{if isset($product.new) && $product.new == 1}
									<a class="new-box" href="{$product.link|escape:'html':'UTF-8'}">
										<span class="new-label">{l s='New'}</span>
									</a>
								{/if}
								{if isset($product.on_sale) && $product.on_sale && isset($product.show_price) && $product.show_price && !$PS_CATALOG_MODE}
									<a class="sale-box" href="{$product.link|escape:'html':'UTF-8'}">
										<span class="sale-label">{l s='Sale!'}</span>
									</a>
								{/if}
							</div>
							{if isset($product.is_virtual) && !$product.is_virtual}{hook h="displayProductDeliveryTime" product=$product}{/if}
							{hook h="displayProductPriceBlock" product=$product type="weight"}
						</div>
						<div class="right-block margin-top-0">
							<h5 itemprop="name">
								{if isset($product.pack_quantity) && $product.pack_quantity}{$product.pack_quantity|intval|cat:' x '}{/if}
								<a class="product-name" href="{$product.link|escape:'html':'UTF-8'}" title="{$product.name|escape:'html':'UTF-8'}" itemprop="url" >
									{$product.name|truncate:45:'...'|escape:'html':'UTF-8'}
								</a>
							</h5>
							{capture name='displayProductListReviews'}{hook h='displayProductListReviews' product=$product}{/capture}
							{if $smarty.capture.displayProductListReviews}
								<div class="hook-reviews">
								{hook h='displayProductListReviews' product=$product}
								</div>
							{/if}
							<p class="product-desc" itemprop="description">
								{$product.description_short|strip_tags:'UTF-8'|truncate:360:'...'}
							</p>
							{if (!$PS_CATALOG_MODE AND ((isset($product.show_price) && $product.show_price) || (isset($product.available_for_order) && $product.available_for_order)))}
						
							<div>
								<div class="col-sm-2 leftl10">
									<span style="float: left; width:40px;margin-top: 7px;"><p class="buttons_bottom_block no-print">
										<a id="wishlist_button_nopop" href="#" onclick="WishlistCart('wishlist_block_list', 'add', '3', $('#idCombination').val(), 1); return false;" rel="nofollow" title="Add to my wishlist">
											<img class="social2" src="{$img_dir}/social2.png" />
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

		                                                   <span><span><img class="social" src="{$img_dir}/social.png" /></span></span>


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

		                        <div class="content_price">
								{if isset($product.show_price) && $product.show_price && !isset($restricted_country_mode)}
									{hook h="displayProductPriceBlock" product=$product type='before_price'}
									<span class="price product-price">
										{if !$priceDisplay}{convertPrice price=$product.price}{else}{convertPrice price=$product.price_tax_exc}{/if}
									</span>
									{if $product.price_without_reduction > 0 && isset($product.specific_prices) && $product.specific_prices && isset($product.specific_prices.reduction) && $product.specific_prices.reduction > 0}
										{hook h="displayProductPriceBlock" product=$product type="old_price"}
										<span class="old-price product-price">
											{displayWtPrice p=$product.price_without_reduction}
										</span>
										{hook h="displayProductPriceBlock" id_product=$product.id_product type="old_price"}
										{if $product.specific_prices.reduction_type == 'percentage'}
											<span class="price-percent-reduction">-{$product.specific_prices.reduction * 100}%</span>
										{/if}
									{/if}
									{hook h="displayProductPriceBlock" product=$product type="price"}
									{hook h="displayProductPriceBlock" product=$product type="unit_price"}
									{hook h="displayProductPriceBlock" product=$product type='after_price'}
								{/if}
							</div>

		                    <div class="car_and_supplier">
		                        <div class="r-seller-link">
		                        	<img src="{$base_uri}modules/marketplace/views/img/shop_img/{$seller_product[$product.name][0]}" width="15" />
		                        	{$seller_product[$product.name][1]}
		                            {hook h='displayProductListSeller' id_product=$product.id_product|escape:'html':'UTF-8'}
		                        </div>

		                        {if ($product.id_product_attribute == 0 || (isset($add_prod_display) && ($add_prod_display == 1))) && $product.available_for_order && !isset($restricted_country_mode) && $product.customizable != 2 && !$PS_CATALOG_MODE}
		                            {if (!isset($product.customization_required) || !$product.customization_required) && ($product.allow_oosp || $product.quantity > 0)}
		                                {capture}add=1&amp;id_product={$product.id_product|intval}{if isset($product.id_product_attribute) && $product.id_product_attribute}&amp;ipa={$product.id_product_attribute|intval}{/if}{if isset($static_token)}&amp;token={$static_token}{/if}{/capture}
		                                <a class="ajax_add_to_cart_button" href="{$link->getPageLink('cart', true, NULL, $smarty.capture.default, false)|escape:'html':'UTF-8'}" rel="nofollow" title="{l s='Add to cart'}" data-id-product-attribute="{$product.id_product_attribute|intval}" data-id-product="{$product.id_product|intval}" data-minimal_quantity="{if isset($product.product_attribute_minimal_quantity) && $product.product_attribute_minimal_quantity >= 1}{$product.product_attribute_minimal_quantity|intval}{else}{$product.minimal_quantity|intval}{/if}">
		                                    <span class="product-cart"></span>
		                                </a>
		                            {else}
		                                <span class="ajax_add_to_cart_button disabled">
											<span class="product-cart"></span>
										</span>
		                            {/if}
		                        {/if}
		                    </div>
							{/if}
							<div class="button-container">

								<a class="button lnk_view btn btn-default" href="{$product.link|escape:'html':'UTF-8'}" title="{l s='View'}">
									<span>{if (isset($product.customization_required) && $product.customization_required)}{l s='Customize'}{else}{l s='More'}{/if}</span>
								</a>
							</div>
							{if isset($product.color_list)}
								<div class="color-list-container">{$product.color_list}</div>
							{/if}
							<div class="product-flags">
								{if (!$PS_CATALOG_MODE AND ((isset($product.show_price) && $product.show_price) || (isset($product.available_for_order) && $product.available_for_order)))}
									{if isset($product.online_only) && $product.online_only}
										<span class="online_only">{l s='Online only'}</span>
									{/if}
								{/if}
								{if isset($product.on_sale) && $product.on_sale && isset($product.show_price) && $product.show_price && !$PS_CATALOG_MODE}
									{elseif isset($product.reduction) && $product.reduction && isset($product.show_price) && $product.show_price && !$PS_CATALOG_MODE}
										<span class="discount">{l s='Reduced price!'}</span>
									{/if}
							</div>
							{if (!$PS_CATALOG_MODE && $PS_STOCK_MANAGEMENT && ((isset($product.show_price) && $product.show_price) || (isset($product.available_for_order) && $product.available_for_order)))}
								{if isset($product.available_for_order) && $product.available_for_order && !isset($restricted_country_mode)}
									<span class="availability">
										{if ($product.allow_oosp || $product.quantity > 0)}
											<span class="{if $product.quantity <= 0 && isset($product.allow_oosp) && !$product.allow_oosp} label-danger{elseif $product.quantity <= 0} label-warning{else} label-success{/if}">
												{if $product.quantity <= 0}{if $product.allow_oosp}{if isset($product.available_later) && $product.available_later}{$product.available_later}{else}{l s='In Stock'}{/if}{else}{l s='Out of stock'}{/if}{else}{if isset($product.available_now) && $product.available_now}{$product.available_now}{else}{l s='In Stock'}{/if}{/if}
											</span>
										{elseif (isset($product.quantity_all_versions) && $product.quantity_all_versions > 0)}
											<span class="label-warning">
												{l s='Product available with different options'}
											</span>
										{else}
											<span class="label-danger">
												{l s='Out of stock'}
											</span>
										{/if}
									</span>
								{/if}
							{/if}
						</div>
						{if $page_name != 'index'}
							<div class="functional-buttons clearfix">
								{hook h='displayProductListFunctionalButtons' product=$product}
								{if isset($comparator_max_item) && $comparator_max_item}
									<div class="compare">
										<a class="add_to_compare" href="{$product.link|escape:'html':'UTF-8'}" data-id-product="{$product.id_product}">{l s='Add to Compare'}</a>
									</div>
								{/if}
							</div>
						{/if}
					</div><!-- .product-container> -->
				</li>
			{/if}	
			{assign var='j' value=$j+1}
			{/foreach}
			</ul>

			{assign var='i' value=2}
			{assign var='j' value=0}
			<ul{if isset($id) && $id} id="{$id}"{/if} class="col-xs-3 col-sm-3 col-md-3 product_list grid row{if isset($class) && $class} {$class}{/if}">
			{foreach from=$products item=product name=products}
			{if $j==$i}
				{math equation="(total%perLine)" total=$smarty.foreach.products.total perLine=$nbItemsPerLine assign=totModulo}
				{math equation="(total%perLineT)" total=$smarty.foreach.products.total perLineT=$nbItemsPerLineTablet assign=totModuloTablet}
				{math equation="(total%perLineT)" total=$smarty.foreach.products.total perLineT=$nbItemsPerLineMobile assign=totModuloMobile}
				{if $totModulo == 0}{assign var='totModulo' value=$nbItemsPerLine}{/if}
				{if $totModuloTablet == 0}{assign var='totModuloTablet' value=$nbItemsPerLineTablet}{/if}
				{if $totModuloMobile == 0}{assign var='totModuloMobile' value=$nbItemsPerLineMobile}{/if}
				{assign var=i value=$i+4}
				<li class="ajax_block_product{if $page_name == 'index' || $page_name == 'product'} col-xs-12 col-sm-12 col-md-12{else} col-xs-12 col-sm-12 col-md-4{/if}{if $smarty.foreach.products.iteration%$nbItemsPerLine == 0} last-in-line{elseif $smarty.foreach.products.iteration%$nbItemsPerLine == 1} first-in-line{/if}{if $smarty.foreach.products.iteration > ($smarty.foreach.products.total - $totModulo)} last-line{/if}{if $smarty.foreach.products.iteration%$nbItemsPerLineTablet == 0} last-item-of-tablet-line{elseif $smarty.foreach.products.iteration%$nbItemsPerLineTablet == 1} first-item-of-tablet-line{/if}{if $smarty.foreach.products.iteration%$nbItemsPerLineMobile == 0} last-item-of-mobile-line{elseif $smarty.foreach.products.iteration%$nbItemsPerLineMobile == 1} first-item-of-mobile-line{/if}{if $smarty.foreach.products.iteration > ($smarty.foreach.products.total - $totModuloMobile)} last-mobile-line{/if}">
					<div class="product-container" itemscope itemtype="https://schema.org/Product">
						<div class="left-block" style="background-image: url({$link->getImageLink($product.link_rewrite, $product.id_image, 'home_default')|escape:'html':'UTF-8'});">
							<div class="product-image-container">
								<a class="product_img_link" href="{$product.link|escape:'html':'UTF-8'}" title="{$product.name|escape:'html':'UTF-8'}" itemprop="url">
									<img style="visibility: hidden;" class="replace-2x img-responsive" src="{$link->getImageLink($product.link_rewrite, $product.id_image, 'home_default')|escape:'html':'UTF-8'}" alt="{if !empty($product.legend)}{$product.legend|escape:'html':'UTF-8'}{else}{$product.name|escape:'html':'UTF-8'}{/if}" title="{if !empty($product.legend)}{$product.legend|escape:'html':'UTF-8'}{else}{$product.name|escape:'html':'UTF-8'}{/if}" {if isset($homeSize)} width="{$homeSize.width}" height="{$homeSize.height}"{/if} itemprop="image" />
								</a>
								{if isset($quick_view) && $quick_view}
									<div class="quick-view-wrapper-mobile">
									<a class="quick-view-mobile" href="{$product.link|escape:'html':'UTF-8'}" rel="{$product.link|escape:'html':'UTF-8'}">
										<i class="icon-eye-open"></i>
									</a>
								</div>
								<a class="quick-view" href="{$product.link|escape:'html':'UTF-8'}" rel="{$product.link|escape:'html':'UTF-8'}">
									<span>{l s='Quick view'}</span>
								</a>
								{/if}
								{if (!$PS_CATALOG_MODE && ((isset($product.show_price) && $product.show_price) || (isset($product.available_for_order) && $product.available_for_order)))}
									<div class="content_price" itemprop="offers" itemscope itemtype="https://schema.org/Offer">
										{if isset($product.show_price) && $product.show_price && !isset($restricted_country_mode)}
											<span itemprop="price" class="price product-price">
												{hook h="displayProductPriceBlock" product=$product type="before_price"}
												{if !$priceDisplay}{convertPrice price=$product.price}{else}{convertPrice price=$product.price_tax_exc}{/if}
											</span>
											<meta itemprop="priceCurrency" content="{$currency->iso_code}" />
											{if $product.price_without_reduction > 0 && isset($product.specific_prices) && $product.specific_prices && isset($product.specific_prices.reduction) && $product.specific_prices.reduction > 0}
												{hook h="displayProductPriceBlock" product=$product type="old_price"}
												<span class="old-price product-price">
													{displayWtPrice p=$product.price_without_reduction}
												</span>
												{if $product.specific_prices.reduction_type == 'percentage'}
													<span class="price-percent-reduction">-{$product.specific_prices.reduction * 100}%</span>
												{/if}
											{/if}
											{if $PS_STOCK_MANAGEMENT && isset($product.available_for_order) && $product.available_for_order && !isset($restricted_country_mode)}
												<span class="unvisible">
													{if ($product.allow_oosp || $product.quantity > 0)}
															<link itemprop="availability" href="https://schema.org/InStock" />{if $product.quantity <= 0}{if $product.allow_oosp}{if isset($product.available_later) && $product.available_later}{$product.available_later}{else}{l s='In Stock'}{/if}{/if}{else}{if isset($product.available_now) && $product.available_now}{$product.available_now}{else}{l s='In Stock'}{/if}{/if}
													{elseif (isset($product.quantity_all_versions) && $product.quantity_all_versions > 0)}
															<link itemprop="availability" href="https://schema.org/LimitedAvailability" />{l s='Product available with different options'}

													{else}
															<link itemprop="availability" href="https://schema.org/OutOfStock" />{l s='Out of stock'}
													{/if}
												</span>
											{/if}
											{hook h="displayProductPriceBlock" product=$product type="price"}
											{hook h="displayProductPriceBlock" product=$product type="unit_price"}
										{/if}
									</div>
								{/if}
								{if isset($product.new) && $product.new == 1}
									<a class="new-box" href="{$product.link|escape:'html':'UTF-8'}">
										<span class="new-label">{l s='New'}</span>
									</a>
								{/if}
								{if isset($product.on_sale) && $product.on_sale && isset($product.show_price) && $product.show_price && !$PS_CATALOG_MODE}
									<a class="sale-box" href="{$product.link|escape:'html':'UTF-8'}">
										<span class="sale-label">{l s='Sale!'}</span>
									</a>
								{/if}
							</div>
							{if isset($product.is_virtual) && !$product.is_virtual}{hook h="displayProductDeliveryTime" product=$product}{/if}
							{hook h="displayProductPriceBlock" product=$product type="weight"}
						</div>
						<div class="right-block margin-top-0">
							<h5 itemprop="name">
								{if isset($product.pack_quantity) && $product.pack_quantity}{$product.pack_quantity|intval|cat:' x '}{/if}
								<a class="product-name" href="{$product.link|escape:'html':'UTF-8'}" title="{$product.name|escape:'html':'UTF-8'}" itemprop="url" >
									{$product.name|truncate:45:'...'|escape:'html':'UTF-8'}
								</a>
							</h5>
							{capture name='displayProductListReviews'}{hook h='displayProductListReviews' product=$product}{/capture}
							{if $smarty.capture.displayProductListReviews}
								<div class="hook-reviews">
								{hook h='displayProductListReviews' product=$product}
								</div>
							{/if}
							<p class="product-desc" itemprop="description">
								{$product.description_short|strip_tags:'UTF-8'|truncate:360:'...'}
							</p>
							{if (!$PS_CATALOG_MODE AND ((isset($product.show_price) && $product.show_price) || (isset($product.available_for_order) && $product.available_for_order)))}
						
							<div>
								<div class="col-sm-2 leftl10">
									<span style="float: left; width:40px;margin-top: 4px;"><p class="buttons_bottom_block no-print">
										<a id="wishlist_button_nopop" href="#" onclick="WishlistCart('wishlist_block_list', 'add', '3', $('#idCombination').val(), 1); return false;" rel="nofollow" title="Add to my wishlist">
											<img class="social2" src="{$img_dir}/social2.png" />
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

		                                                   <span><span><img class="social" src="{$img_dir}/social.png" /></span></span>


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

		                        <div class="content_price">
								{if isset($product.show_price) && $product.show_price && !isset($restricted_country_mode)}
									{hook h="displayProductPriceBlock" product=$product type='before_price'}
									<span class="price product-price">
										{if !$priceDisplay}{convertPrice price=$product.price}{else}{convertPrice price=$product.price_tax_exc}{/if}
									</span>
									{if $product.price_without_reduction > 0 && isset($product.specific_prices) && $product.specific_prices && isset($product.specific_prices.reduction) && $product.specific_prices.reduction > 0}
										{hook h="displayProductPriceBlock" product=$product type="old_price"}
										<span class="old-price product-price">
											{displayWtPrice p=$product.price_without_reduction}
										</span>
										{hook h="displayProductPriceBlock" id_product=$product.id_product type="old_price"}
										{if $product.specific_prices.reduction_type == 'percentage'}
											<span class="price-percent-reduction">-{$product.specific_prices.reduction * 100}%</span>
										{/if}
									{/if}
									{hook h="displayProductPriceBlock" product=$product type="price"}
									{hook h="displayProductPriceBlock" product=$product type="unit_price"}
									{hook h="displayProductPriceBlock" product=$product type='after_price'}
								{/if}
							</div>

		                    <div class="car_and_supplier">
		                        <div class="r-seller-link">
		                        	<img src="{$base_uri}modules/marketplace/views/img/shop_img/{$seller_product[$product.name][0]}" width="15" />
		                        	{$seller_product[$product.name][1]}
		                            {hook h='displayProductListSeller' id_product=$product.id_product|escape:'html':'UTF-8'}
		                        </div>

		                        {if ($product.id_product_attribute == 0 || (isset($add_prod_display) && ($add_prod_display == 1))) && $product.available_for_order && !isset($restricted_country_mode) && $product.customizable != 2 && !$PS_CATALOG_MODE}
		                            {if (!isset($product.customization_required) || !$product.customization_required) && ($product.allow_oosp || $product.quantity > 0)}
		                                {capture}add=1&amp;id_product={$product.id_product|intval}{if isset($product.id_product_attribute) && $product.id_product_attribute}&amp;ipa={$product.id_product_attribute|intval}{/if}{if isset($static_token)}&amp;token={$static_token}{/if}{/capture}
		                                <a class="ajax_add_to_cart_button" href="{$link->getPageLink('cart', true, NULL, $smarty.capture.default, false)|escape:'html':'UTF-8'}" rel="nofollow" title="{l s='Add to cart'}" data-id-product-attribute="{$product.id_product_attribute|intval}" data-id-product="{$product.id_product|intval}" data-minimal_quantity="{if isset($product.product_attribute_minimal_quantity) && $product.product_attribute_minimal_quantity >= 1}{$product.product_attribute_minimal_quantity|intval}{else}{$product.minimal_quantity|intval}{/if}">
		                                    <span class="product-cart"></span>
		                                </a>
		                            {else}
		                                <span class="ajax_add_to_cart_button disabled">
											<span class="product-cart"></span>
										</span>
		                            {/if}
		                        {/if}
		                    </div>
							{/if}
							<div class="button-container">

								<a class="button lnk_view btn btn-default" href="{$product.link|escape:'html':'UTF-8'}" title="{l s='View'}">
									<span>{if (isset($product.customization_required) && $product.customization_required)}{l s='Customize'}{else}{l s='More'}{/if}</span>
								</a>
							</div>
							{if isset($product.color_list)}
								<div class="color-list-container">{$product.color_list}</div>
							{/if}
							<div class="product-flags">
								{if (!$PS_CATALOG_MODE AND ((isset($product.show_price) && $product.show_price) || (isset($product.available_for_order) && $product.available_for_order)))}
									{if isset($product.online_only) && $product.online_only}
										<span class="online_only">{l s='Online only'}</span>
									{/if}
								{/if}
								{if isset($product.on_sale) && $product.on_sale && isset($product.show_price) && $product.show_price && !$PS_CATALOG_MODE}
									{elseif isset($product.reduction) && $product.reduction && isset($product.show_price) && $product.show_price && !$PS_CATALOG_MODE}
										<span class="discount">{l s='Reduced price!'}</span>
									{/if}
							</div>
							{if (!$PS_CATALOG_MODE && $PS_STOCK_MANAGEMENT && ((isset($product.show_price) && $product.show_price) || (isset($product.available_for_order) && $product.available_for_order)))}
								{if isset($product.available_for_order) && $product.available_for_order && !isset($restricted_country_mode)}
									<span class="availability">
										{if ($product.allow_oosp || $product.quantity > 0)}
											<span class="{if $product.quantity <= 0 && isset($product.allow_oosp) && !$product.allow_oosp} label-danger{elseif $product.quantity <= 0} label-warning{else} label-success{/if}">
												{if $product.quantity <= 0}{if $product.allow_oosp}{if isset($product.available_later) && $product.available_later}{$product.available_later}{else}{l s='In Stock'}{/if}{else}{l s='Out of stock'}{/if}{else}{if isset($product.available_now) && $product.available_now}{$product.available_now}{else}{l s='In Stock'}{/if}{/if}
											</span>
										{elseif (isset($product.quantity_all_versions) && $product.quantity_all_versions > 0)}
											<span class="label-warning">
												{l s='Product available with different options'}
											</span>
										{else}
											<span class="label-danger">
												{l s='Out of stock'}
											</span>
										{/if}
									</span>
								{/if}
							{/if}
						</div>
						{if $page_name != 'index'}
							<div class="functional-buttons clearfix">
								{hook h='displayProductListFunctionalButtons' product=$product}
								{if isset($comparator_max_item) && $comparator_max_item}
									<div class="compare">
										<a class="add_to_compare" href="{$product.link|escape:'html':'UTF-8'}" data-id-product="{$product.id_product}">{l s='Add to Compare'}</a>
									</div>
								{/if}
							</div>
						{/if}
					</div><!-- .product-container> -->
				</li>
			{/if}	
			{assign var='j' value=$j+1}
			{/foreach}
			</ul>


			{assign var='i' value=3}
			{assign var='j' value=0}
			<ul{if isset($id) && $id} id="{$id}"{/if} class="col-lg-3 product_list grid row{if isset($class) && $class} {$class}{/if}">
			{foreach from=$products item=product name=products}
			{if $j==$i}
				{math equation="(total%perLine)" total=$smarty.foreach.products.total perLine=$nbItemsPerLine assign=totModulo}
				{math equation="(total%perLineT)" total=$smarty.foreach.products.total perLineT=$nbItemsPerLineTablet assign=totModuloTablet}
				{math equation="(total%perLineT)" total=$smarty.foreach.products.total perLineT=$nbItemsPerLineMobile assign=totModuloMobile}
				{if $totModulo == 0}{assign var='totModulo' value=$nbItemsPerLine}{/if}
				{if $totModuloTablet == 0}{assign var='totModuloTablet' value=$nbItemsPerLineTablet}{/if}
				{if $totModuloMobile == 0}{assign var='totModuloMobile' value=$nbItemsPerLineMobile}{/if}
				{assign var=i value=$i+4}
				<li class="ajax_block_product{if $page_name == 'index' || $page_name == 'product'} col-xs-12 col-sm-12 col-md-12{else} col-xs-12 col-sm-12 col-md-4{/if}{if $smarty.foreach.products.iteration%$nbItemsPerLine == 0} last-in-line{elseif $smarty.foreach.products.iteration%$nbItemsPerLine == 1} first-in-line{/if}{if $smarty.foreach.products.iteration > ($smarty.foreach.products.total - $totModulo)} last-line{/if}{if $smarty.foreach.products.iteration%$nbItemsPerLineTablet == 0} last-item-of-tablet-line{elseif $smarty.foreach.products.iteration%$nbItemsPerLineTablet == 1} first-item-of-tablet-line{/if}{if $smarty.foreach.products.iteration%$nbItemsPerLineMobile == 0} last-item-of-mobile-line{elseif $smarty.foreach.products.iteration%$nbItemsPerLineMobile == 1} first-item-of-mobile-line{/if}{if $smarty.foreach.products.iteration > ($smarty.foreach.products.total - $totModuloMobile)} last-mobile-line{/if}">
					<div class="product-container" itemscope itemtype="https://schema.org/Product">
						<div class="left-block" style="background-image: url({$link->getImageLink($product.link_rewrite, $product.id_image, 'home_default')|escape:'html':'UTF-8'});">
							<div class="product-image-container">
								<a class="product_img_link" href="{$product.link|escape:'html':'UTF-8'}" title="{$product.name|escape:'html':'UTF-8'}" itemprop="url">
									<img style="visibility: hidden;" class="replace-2x img-responsive" src="{$link->getImageLink($product.link_rewrite, $product.id_image, 'home_default')|escape:'html':'UTF-8'}" alt="{if !empty($product.legend)}{$product.legend|escape:'html':'UTF-8'}{else}{$product.name|escape:'html':'UTF-8'}{/if}" title="{if !empty($product.legend)}{$product.legend|escape:'html':'UTF-8'}{else}{$product.name|escape:'html':'UTF-8'}{/if}" {if isset($homeSize)} width="{$homeSize.width}" height="{$homeSize.height}"{/if} itemprop="image" />
								</a>
								{if isset($quick_view) && $quick_view}
									<div class="quick-view-wrapper-mobile">
									<a class="quick-view-mobile" href="{$product.link|escape:'html':'UTF-8'}" rel="{$product.link|escape:'html':'UTF-8'}">
										<i class="icon-eye-open"></i>
									</a>
								</div>
								<a class="quick-view" href="{$product.link|escape:'html':'UTF-8'}" rel="{$product.link|escape:'html':'UTF-8'}">
									<span>{l s='Quick view'}</span>
								</a>
								{/if}
								{if (!$PS_CATALOG_MODE && ((isset($product.show_price) && $product.show_price) || (isset($product.available_for_order) && $product.available_for_order)))}
									<div class="content_price" itemprop="offers" itemscope itemtype="https://schema.org/Offer">
										{if isset($product.show_price) && $product.show_price && !isset($restricted_country_mode)}
											<span itemprop="price" class="price product-price">
												{hook h="displayProductPriceBlock" product=$product type="before_price"}
												{if !$priceDisplay}{convertPrice price=$product.price}{else}{convertPrice price=$product.price_tax_exc}{/if}
											</span>
											<meta itemprop="priceCurrency" content="{$currency->iso_code}" />
											{if $product.price_without_reduction > 0 && isset($product.specific_prices) && $product.specific_prices && isset($product.specific_prices.reduction) && $product.specific_prices.reduction > 0}
												{hook h="displayProductPriceBlock" product=$product type="old_price"}
												<span class="old-price product-price">
													{displayWtPrice p=$product.price_without_reduction}
												</span>
												{if $product.specific_prices.reduction_type == 'percentage'}
													<span class="price-percent-reduction">-{$product.specific_prices.reduction * 100}%</span>
												{/if}
											{/if}
											{if $PS_STOCK_MANAGEMENT && isset($product.available_for_order) && $product.available_for_order && !isset($restricted_country_mode)}
												<span class="unvisible">
													{if ($product.allow_oosp || $product.quantity > 0)}
															<link itemprop="availability" href="https://schema.org/InStock" />{if $product.quantity <= 0}{if $product.allow_oosp}{if isset($product.available_later) && $product.available_later}{$product.available_later}{else}{l s='In Stock'}{/if}{/if}{else}{if isset($product.available_now) && $product.available_now}{$product.available_now}{else}{l s='In Stock'}{/if}{/if}
													{elseif (isset($product.quantity_all_versions) && $product.quantity_all_versions > 0)}
															<link itemprop="availability" href="https://schema.org/LimitedAvailability" />{l s='Product available with different options'}

													{else}
															<link itemprop="availability" href="https://schema.org/OutOfStock" />{l s='Out of stock'}
													{/if}
												</span>
											{/if}
											{hook h="displayProductPriceBlock" product=$product type="price"}
											{hook h="displayProductPriceBlock" product=$product type="unit_price"}
										{/if}
									</div>
								{/if}
								{if isset($product.new) && $product.new == 1}
									<a class="new-box" href="{$product.link|escape:'html':'UTF-8'}">
										<span class="new-label">{l s='New'}</span>
									</a>
								{/if}
								{if isset($product.on_sale) && $product.on_sale && isset($product.show_price) && $product.show_price && !$PS_CATALOG_MODE}
									<a class="sale-box" href="{$product.link|escape:'html':'UTF-8'}">
										<span class="sale-label">{l s='Sale!'}</span>
									</a>
								{/if}
							</div>
							{if isset($product.is_virtual) && !$product.is_virtual}{hook h="displayProductDeliveryTime" product=$product}{/if}
							{hook h="displayProductPriceBlock" product=$product type="weight"}
						</div>
						<div class="right-block margin-top-0">
							<h5 itemprop="name">
								{if isset($product.pack_quantity) && $product.pack_quantity}{$product.pack_quantity|intval|cat:' x '}{/if}
								<a class="product-name" href="{$product.link|escape:'html':'UTF-8'}" title="{$product.name|escape:'html':'UTF-8'}" itemprop="url" >
									{$product.name|truncate:45:'...'|escape:'html':'UTF-8'}
								</a>
							</h5>
							{capture name='displayProductListReviews'}{hook h='displayProductListReviews' product=$product}{/capture}
							{if $smarty.capture.displayProductListReviews}
								<div class="hook-reviews">
								{hook h='displayProductListReviews' product=$product}
								</div>
							{/if}
							<p class="product-desc" itemprop="description">
								{$product.description_short|strip_tags:'UTF-8'|truncate:360:'...'}
							</p>
							{if (!$PS_CATALOG_MODE AND ((isset($product.show_price) && $product.show_price) || (isset($product.available_for_order) && $product.available_for_order)))}
						
							<div>
								<div class="col-sm-2 leftl10">
									<span style="float: left; width:40px;margin-top: 7px;"><p class="buttons_bottom_block no-print">
										<a id="wishlist_button_nopop" href="#" onclick="WishlistCart('wishlist_block_list', 'add', '3', $('#idCombination').val(), 1); return false;" rel="nofollow" title="Add to my wishlist">
											<img class="social2" src="{$img_dir}/social2.png" />
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

		                                                   <span><span><img class="social" src="{$img_dir}/social.png" /></span></span>


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

		                        <div class="content_price">
								{if isset($product.show_price) && $product.show_price && !isset($restricted_country_mode)}
									{hook h="displayProductPriceBlock" product=$product type='before_price'}
									<span class="price product-price">
										{if !$priceDisplay}{convertPrice price=$product.price}{else}{convertPrice price=$product.price_tax_exc}{/if}
									</span>
									{if $product.price_without_reduction > 0 && isset($product.specific_prices) && $product.specific_prices && isset($product.specific_prices.reduction) && $product.specific_prices.reduction > 0}
										{hook h="displayProductPriceBlock" product=$product type="old_price"}
										<span class="old-price product-price">
											{displayWtPrice p=$product.price_without_reduction}
										</span>
										{hook h="displayProductPriceBlock" id_product=$product.id_product type="old_price"}
										{if $product.specific_prices.reduction_type == 'percentage'}
											<span class="price-percent-reduction">-{$product.specific_prices.reduction * 100}%</span>
										{/if}
									{/if}
									{hook h="displayProductPriceBlock" product=$product type="price"}
									{hook h="displayProductPriceBlock" product=$product type="unit_price"}
									{hook h="displayProductPriceBlock" product=$product type='after_price'}
								{/if}
							</div>

		                    <div class="car_and_supplier">
		                        <div class="r-seller-link">
		                        	<img src="{$base_uri}modules/marketplace/views/img/shop_img/{$seller_product[$product.name][0]}" width="15" />
		                        	{$seller_product[$product.name][1]}
		                            {hook h='displayProductListSeller' id_product=$product.id_product|escape:'html':'UTF-8'}
		                        </div>

		                        {if ($product.id_product_attribute == 0 || (isset($add_prod_display) && ($add_prod_display == 1))) && $product.available_for_order && !isset($restricted_country_mode) && $product.customizable != 2 && !$PS_CATALOG_MODE}
		                            {if (!isset($product.customization_required) || !$product.customization_required) && ($product.allow_oosp || $product.quantity > 0)}
		                                {capture}add=1&amp;id_product={$product.id_product|intval}{if isset($product.id_product_attribute) && $product.id_product_attribute}&amp;ipa={$product.id_product_attribute|intval}{/if}{if isset($static_token)}&amp;token={$static_token}{/if}{/capture}
		                                <a class="ajax_add_to_cart_button" href="{$link->getPageLink('cart', true, NULL, $smarty.capture.default, false)|escape:'html':'UTF-8'}" rel="nofollow" title="{l s='Add to cart'}" data-id-product-attribute="{$product.id_product_attribute|intval}" data-id-product="{$product.id_product|intval}" data-minimal_quantity="{if isset($product.product_attribute_minimal_quantity) && $product.product_attribute_minimal_quantity >= 1}{$product.product_attribute_minimal_quantity|intval}{else}{$product.minimal_quantity|intval}{/if}">
		                                    <span class="product-cart"></span>
		                                </a>
		                            {else}
		                                <span class="ajax_add_to_cart_button disabled">
											<span class="product-cart"></span>
										</span>
		                            {/if}
		                        {/if}
		                    </div>
							{/if}
							<div class="button-container">

								<a class="button lnk_view btn btn-default" href="{$product.link|escape:'html':'UTF-8'}" title="{l s='View'}">
									<span>{if (isset($product.customization_required) && $product.customization_required)}{l s='Customize'}{else}{l s='More'}{/if}</span>
								</a>
							</div>
							{if isset($product.color_list)}
								<div class="color-list-container">{$product.color_list}</div>
							{/if}
							<div class="product-flags">
								{if (!$PS_CATALOG_MODE AND ((isset($product.show_price) && $product.show_price) || (isset($product.available_for_order) && $product.available_for_order)))}
									{if isset($product.online_only) && $product.online_only}
										<span class="online_only">{l s='Online only'}</span>
									{/if}
								{/if}
								{if isset($product.on_sale) && $product.on_sale && isset($product.show_price) && $product.show_price && !$PS_CATALOG_MODE}
									{elseif isset($product.reduction) && $product.reduction && isset($product.show_price) && $product.show_price && !$PS_CATALOG_MODE}
										<span class="discount">{l s='Reduced price!'}</span>
									{/if}
							</div>
							{if (!$PS_CATALOG_MODE && $PS_STOCK_MANAGEMENT && ((isset($product.show_price) && $product.show_price) || (isset($product.available_for_order) && $product.available_for_order)))}
								{if isset($product.available_for_order) && $product.available_for_order && !isset($restricted_country_mode)}
									<span class="availability">
										{if ($product.allow_oosp || $product.quantity > 0)}
											<span class="{if $product.quantity <= 0 && isset($product.allow_oosp) && !$product.allow_oosp} label-danger{elseif $product.quantity <= 0} label-warning{else} label-success{/if}">
												{if $product.quantity <= 0}{if $product.allow_oosp}{if isset($product.available_later) && $product.available_later}{$product.available_later}{else}{l s='In Stock'}{/if}{else}{l s='Out of stock'}{/if}{else}{if isset($product.available_now) && $product.available_now}{$product.available_now}{else}{l s='In Stock'}{/if}{/if}
											</span>
										{elseif (isset($product.quantity_all_versions) && $product.quantity_all_versions > 0)}
											<span class="label-warning">
												{l s='Product available with different options'}
											</span>
										{else}
											<span class="label-danger">
												{l s='Out of stock'}
											</span>
										{/if}
									</span>
								{/if}
							{/if}
						</div>
						{if $page_name != 'index'}
							<div class="functional-buttons clearfix">
								{hook h='displayProductListFunctionalButtons' product=$product}
								{if isset($comparator_max_item) && $comparator_max_item}
									<div class="compare">
										<a class="add_to_compare" href="{$product.link|escape:'html':'UTF-8'}" data-id-product="{$product.id_product}">{l s='Add to Compare'}</a>
									</div>
								{/if}
							</div>
						{/if}
					</div><!-- .product-container> -->
				</li>
			{/if}	
			{assign var='j' value=$j+1}
			{/foreach}
			</ul>

		{addJsDefL name=min_item}{l s='Please select at least one product' js=1}{/addJsDefL}
		{addJsDefL name=max_item}{l s='You cannot add more than %d product(s) to the product comparison' sprintf=$comparator_max_item js=1}{/addJsDefL}
		{addJsDef comparator_max_item=$comparator_max_item}
		{addJsDef comparedProductsIds=$compared_products}
		{/if}
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
			// $('#blockbestsellers li').wookmark({
			// 	autoResize: true, // This will auto-update the layout when the browser window is resized.
			// 	offset: 2, // Optional, the distance between grid items
			// 	itemWidth: 210 // Optional, the width of a grid item
			// });
		</script>
	{else}	
		<!-- no registrado; listado de vendedores		 -->
		{foreach from=$sellers item=seller name=sellers}
			<ul  class="product_list grid row {if isset($id) && $id} {$id}{/if}" style="float:left;margin-right: 25px;">
				<li>
					<div class="product-container" style="background-color: transparent;border:none;">
						<img class="replace-2x img-responsive" src="{$base_uri}{$seller.logo}" alt="{if !empty($product.legend)}{$product.legend|escape:'html':'UTF-8'}{else}{$product.name|escape:'html':'UTF-8'}{/if}" style="width:250px;margin-right: 20px;border-radius: 50px;" title="{if !empty($product.legend)}{$product.legend|escape:'html':'UTF-8'}{else}{$product.name|escape:'html':'UTF-8'}{/if}" {if isset($homeSize)} width="{$homeSize.width}" height="{$homeSize.height}"{/if} itemprop="image" />

						<div class="right-block" style="border: 1px solid black;border-radius: 20px;min-height: 85px; width:92%;">
						    <h5 itemprop="name">
						        <a class="product-name"
						           href="{$base_uri}module/marketplace/editprofile?i={$seller.id_customer}&j={$seller.id}"
						           title="{$seller.shop_name}" itemprop="url"
						           style="font-weight: bold;">
						            {$seller.shop_name}
						        </a>
						    </h5>

						    <p class="product-desc" itemprop="description">
						        100% cotton double printed dress. Black and white striped top and orange high waisted skater skirt bottom.
						    </p>

						    <div>
						        <div class="col-sm-2 leftl10">
															<span style="float: left; width:40px;margin-top: 7px;"><p
						                                            class="buttons_bottom_block no-print">
						                                        <a id="wishlist_button_nopop" href="#"
						                                           onclick="WishlistCart('wishlist_block_list', 'add', '3', $('#idCombination').val(), 1); return false;"
						                                           rel="nofollow" title="Add to my wishlist">
						                                            <img class="social2"
						                                                 src="http://localhost/prestashop_1.6.1.6_es/prestashop/themes/rem-theme/img//social2.png">
						                                        </a>
						                                    </p>
															</span>
						        </div>
                                <div class="r_product_share_menu col-sm-2">

                                    <div class="sf-contener clearfix col-lg-12">


                                    <div class="sf-contener clearfix col-lg-12">


                                        <ul class="sf-menu clearfix menu-content sf-arrows">

                                            <li class="">
                                                       <span>
                                                           <!-- <span class="menu-img"></span> -->

                                                           <span><span><img class="social" src="{$img_dir}/social.png" /></span></span>


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

						        <div class="content_price">
																							
															<span class="price product-price">
																									</span>


						        </div>

						        <div class="car_and_supplier">
						            <div class="r-seller-link" {if !$cookie->isLogged()}style="margin-top:10px;font-size:150px;font-size:10px;"{/if}>
										{$seller.seller_name}
						            </div>

						            <a class="ajax_add_to_cart_button"
						               href="http://localhost/prestashop_1.6.1.6_es/prestashop/cart?add=1&amp;id_product=3&amp;ipa=13&amp;token=351f0bf5d9c4863cc82b8df72724e9d0"
						               rel="nofollow" title="Add to cart" data-id-product-attribute="13" data-id-product="3"
						               data-minimal_quantity="1">
						                
						            </a>
						        </div>
						        <div class="button-container" style="display: none;">

						            <a class="button lnk_view btn btn-default"
						               href="http://localhost/prestashop_1.6.1.6_es/prestashop/casual-dresses/3-printed-dress.html"
						               title="View">
						                <span>More</span>
						            </a>
						        </div>
						        <div class="product-flags">
						        </div>
																											
						    </div>
						</div>	

					</div>
				</li>
			</ul>
		{/foreach}
		<script type="text/javascript">
			$(document).ready(function(){
				$('.product_list').hide();
				$('.homefeatured').show();
			})
		</script>
	{/if}	
{else}	
	{if isset($products) && $products}
		{*define number of products per line in other page for desktop*}
		{if $page_name !='index' && $page_name !='product'}
			{assign var='nbItemsPerLine' value=3}
			{assign var='nbItemsPerLineTablet' value=2}
			{assign var='nbItemsPerLineMobile' value=3}
		{else}
			{assign var='nbItemsPerLine' value=4}
			{assign var='nbItemsPerLineTablet' value=3}
			{assign var='nbItemsPerLineMobile' value=2}
		{/if}
		{*define numbers of product per line in other page for tablet*}
		{assign var='nbLi' value=$products|@count}
		{math equation="nbLi/nbItemsPerLine" nbLi=$nbLi nbItemsPerLine=$nbItemsPerLine assign=nbLines}
		{math equation="nbLi/nbItemsPerLineTablet" nbLi=$nbLi nbItemsPerLineTablet=$nbItemsPerLineTablet assign=nbLinesTablet}
		<!-- Products list -->
		<ul{if isset($id) && $id} id="{$id}"{/if} class="product_list grid row{if isset($class) && $class} {$class}{/if}">
		{foreach from=$products item=product name=products}
			{math equation="(total%perLine)" total=$smarty.foreach.products.total perLine=$nbItemsPerLine assign=totModulo}
			{math equation="(total%perLineT)" total=$smarty.foreach.products.total perLineT=$nbItemsPerLineTablet assign=totModuloTablet}
			{math equation="(total%perLineT)" total=$smarty.foreach.products.total perLineT=$nbItemsPerLineMobile assign=totModuloMobile}
			{if $totModulo == 0}{assign var='totModulo' value=$nbItemsPerLine}{/if}
			{if $totModuloTablet == 0}{assign var='totModuloTablet' value=$nbItemsPerLineTablet}{/if}
			{if $totModuloMobile == 0}{assign var='totModuloMobile' value=$nbItemsPerLineMobile}{/if}
			<li class="ajax_block_product{if $page_name == 'index' || $page_name == 'product'} col-xs-12 col-sm-4 col-md-3{else} col-xs-12 col-sm-6 col-md-4{/if}{if $smarty.foreach.products.iteration%$nbItemsPerLine == 0} last-in-line{elseif $smarty.foreach.products.iteration%$nbItemsPerLine == 1} first-in-line{/if}{if $smarty.foreach.products.iteration > ($smarty.foreach.products.total - $totModulo)} last-line{/if}{if $smarty.foreach.products.iteration%$nbItemsPerLineTablet == 0} last-item-of-tablet-line{elseif $smarty.foreach.products.iteration%$nbItemsPerLineTablet == 1} first-item-of-tablet-line{/if}{if $smarty.foreach.products.iteration%$nbItemsPerLineMobile == 0} last-item-of-mobile-line{elseif $smarty.foreach.products.iteration%$nbItemsPerLineMobile == 1} first-item-of-mobile-line{/if}{if $smarty.foreach.products.iteration > ($smarty.foreach.products.total - $totModuloMobile)} last-mobile-line{/if}">
				<div class="product-container" itemscope itemtype="https://schema.org/Product">
					<div class="left-block">
						<div class="product-image-container">
							<a class="product_img_link" href="{$product.link|escape:'html':'UTF-8'}" title="{$product.name|escape:'html':'UTF-8'}" itemprop="url">
								<img class="replace-2x img-responsive" src="{$link->getImageLink($product.link_rewrite, $product.id_image, 'home_default')|escape:'html':'UTF-8'}" alt="{if !empty($product.legend)}{$product.legend|escape:'html':'UTF-8'}{else}{$product.name|escape:'html':'UTF-8'}{/if}" title="{if !empty($product.legend)}{$product.legend|escape:'html':'UTF-8'}{else}{$product.name|escape:'html':'UTF-8'}{/if}" {if isset($homeSize)} width="{$homeSize.width}" height="{$homeSize.height}"{/if} itemprop="image" />
							</a>
							{if isset($quick_view) && $quick_view}
								<div class="quick-view-wrapper-mobile">
								<a class="quick-view-mobile" href="{$product.link|escape:'html':'UTF-8'}" rel="{$product.link|escape:'html':'UTF-8'}">
									<i class="icon-eye-open"></i>
								</a>
							</div>
							<a class="quick-view" href="{$product.link|escape:'html':'UTF-8'}" rel="{$product.link|escape:'html':'UTF-8'}">
								<span>{l s='Quick view'}</span>
							</a>
							{/if}
							{if (!$PS_CATALOG_MODE && ((isset($product.show_price) && $product.show_price) || (isset($product.available_for_order) && $product.available_for_order)))}
								<div class="content_price" itemprop="offers" itemscope itemtype="https://schema.org/Offer">
									{if isset($product.show_price) && $product.show_price && !isset($restricted_country_mode)}
										<span itemprop="price" class="price product-price">
											{hook h="displayProductPriceBlock" product=$product type="before_price"}
											{if !$priceDisplay}{convertPrice price=$product.price}{else}{convertPrice price=$product.price_tax_exc}{/if}
										</span>
										<meta itemprop="priceCurrency" content="{$currency->iso_code}" />
										{if $product.price_without_reduction > 0 && isset($product.specific_prices) && $product.specific_prices && isset($product.specific_prices.reduction) && $product.specific_prices.reduction > 0}
											{hook h="displayProductPriceBlock" product=$product type="old_price"}
											<span class="old-price product-price">
												{displayWtPrice p=$product.price_without_reduction}
											</span>
											{if $product.specific_prices.reduction_type == 'percentage'}
												<span class="price-percent-reduction">-{$product.specific_prices.reduction * 100}%</span>
											{/if}
										{/if}
										{if $PS_STOCK_MANAGEMENT && isset($product.available_for_order) && $product.available_for_order && !isset($restricted_country_mode)}
											<span class="unvisible">
												{if ($product.allow_oosp || $product.quantity > 0)}
														<link itemprop="availability" href="https://schema.org/InStock" />{if $product.quantity <= 0}{if $product.allow_oosp}{if isset($product.available_later) && $product.available_later}{$product.available_later}{else}{l s='In Stock'}{/if}{/if}{else}{if isset($product.available_now) && $product.available_now}{$product.available_now}{else}{l s='In Stock'}{/if}{/if}
												{elseif (isset($product.quantity_all_versions) && $product.quantity_all_versions > 0)}
														<link itemprop="availability" href="https://schema.org/LimitedAvailability" />{l s='Product available with different options'}

												{else}
														<link itemprop="availability" href="https://schema.org/OutOfStock" />{l s='Out of stock'}
												{/if}
											</span>
										{/if}
										{hook h="displayProductPriceBlock" product=$product type="price"}
										{hook h="displayProductPriceBlock" product=$product type="unit_price"}
									{/if}
								</div>
							{/if}
							{if isset($product.new) && $product.new == 1}
								<a class="new-box" href="{$product.link|escape:'html':'UTF-8'}">
									<span class="new-label">{l s='New'}</span>
								</a>
							{/if}
							{if isset($product.on_sale) && $product.on_sale && isset($product.show_price) && $product.show_price && !$PS_CATALOG_MODE}
								<a class="sale-box" href="{$product.link|escape:'html':'UTF-8'}">
									<span class="sale-label">{l s='Sale!'}</span>
								</a>
							{/if}
						</div>
						{if isset($product.is_virtual) && !$product.is_virtual}{hook h="displayProductDeliveryTime" product=$product}{/if}
						{hook h="displayProductPriceBlock" product=$product type="weight"}
					</div>
					<div class="right-block">
						<h5 itemprop="name">
							{if isset($product.pack_quantity) && $product.pack_quantity}{$product.pack_quantity|intval|cat:' x '}{/if}
							<a class="product-name" href="{$product.link|escape:'html':'UTF-8'}" title="{$product.name|escape:'html':'UTF-8'}" itemprop="url" >
								{$product.name|truncate:45:'...'|escape:'html':'UTF-8'}
							</a>
						</h5>
						{capture name='displayProductListReviews'}{hook h='displayProductListReviews' product=$product}{/capture}
						{if $smarty.capture.displayProductListReviews}
							<div class="hook-reviews">
							{hook h='displayProductListReviews' product=$product}
							</div>
						{/if}
						<p class="product-desc" itemprop="description">
							{$product.description_short|strip_tags:'UTF-8'|truncate:360:'...'}
						</p>
						{if (!$PS_CATALOG_MODE AND ((isset($product.show_price) && $product.show_price) || (isset($product.available_for_order) && $product.available_for_order)))}
						<div class="content_price">
							{if isset($product.show_price) && $product.show_price && !isset($restricted_country_mode)}
								{hook h="displayProductPriceBlock" product=$product type='before_price'}
								<span class="price product-price">
									{if !$priceDisplay}{convertPrice price=$product.price}{else}{convertPrice price=$product.price_tax_exc}{/if}
								</span>
								{if $product.price_without_reduction > 0 && isset($product.specific_prices) && $product.specific_prices && isset($product.specific_prices.reduction) && $product.specific_prices.reduction > 0}
									{hook h="displayProductPriceBlock" product=$product type="old_price"}
									<span class="old-price product-price">
										{displayWtPrice p=$product.price_without_reduction}
									</span>
									{hook h="displayProductPriceBlock" id_product=$product.id_product type="old_price"}
									{if $product.specific_prices.reduction_type == 'percentage'}
										<span class="price-percent-reduction">-{$product.specific_prices.reduction * 100}%</span>
									{/if}
								{/if}
								{hook h="displayProductPriceBlock" product=$product type="price"}
								{hook h="displayProductPriceBlock" product=$product type="unit_price"}
								{hook h="displayProductPriceBlock" product=$product type='after_price'}
							{/if}
						</div>
						{/if}
						<div class="button-container">
							{if ($product.id_product_attribute == 0 || (isset($add_prod_display) && ($add_prod_display == 1))) && $product.available_for_order && !isset($restricted_country_mode) && $product.customizable != 2 && !$PS_CATALOG_MODE}
								{if (!isset($product.customization_required) || !$product.customization_required) && ($product.allow_oosp || $product.quantity > 0)}
									{capture}add=1&amp;id_product={$product.id_product|intval}{if isset($product.id_product_attribute) && $product.id_product_attribute}&amp;ipa={$product.id_product_attribute|intval}{/if}{if isset($static_token)}&amp;token={$static_token}{/if}{/capture}
									<a class="button ajax_add_to_cart_button btn btn-default" href="{$link->getPageLink('cart', true, NULL, $smarty.capture.default, false)|escape:'html':'UTF-8'}" rel="nofollow" title="{l s='Add to cart'}" data-id-product-attribute="{$product.id_product_attribute|intval}" data-id-product="{$product.id_product|intval}" data-minimal_quantity="{if isset($product.product_attribute_minimal_quantity) && $product.product_attribute_minimal_quantity >= 1}{$product.product_attribute_minimal_quantity|intval}{else}{$product.minimal_quantity|intval}{/if}">
										<span>{l s='Add to cart'}</span>
									</a>
								{else}
									<span class="button ajax_add_to_cart_button btn btn-default disabled">
										<span>{l s='Add to cart'}</span>
									</span>
								{/if}
							{/if}
							<a class="button lnk_view btn btn-default" href="{$product.link|escape:'html':'UTF-8'}" title="{l s='View'}">
								<span>{if (isset($product.customization_required) && $product.customization_required)}{l s='Customize'}{else}{l s='More'}{/if}</span>
							</a>
						</div>
						{if isset($product.color_list)}
							<div class="color-list-container">{$product.color_list}</div>
						{/if}
						<div class="product-flags">
							{if (!$PS_CATALOG_MODE AND ((isset($product.show_price) && $product.show_price) || (isset($product.available_for_order) && $product.available_for_order)))}
								{if isset($product.online_only) && $product.online_only}
									<span class="online_only">{l s='Online only'}</span>
								{/if}
							{/if}
							{if isset($product.on_sale) && $product.on_sale && isset($product.show_price) && $product.show_price && !$PS_CATALOG_MODE}
								{elseif isset($product.reduction) && $product.reduction && isset($product.show_price) && $product.show_price && !$PS_CATALOG_MODE}
									<span class="discount">{l s='Reduced price!'}</span>
								{/if}
						</div>
						{if (!$PS_CATALOG_MODE && $PS_STOCK_MANAGEMENT && ((isset($product.show_price) && $product.show_price) || (isset($product.available_for_order) && $product.available_for_order)))}
							{if isset($product.available_for_order) && $product.available_for_order && !isset($restricted_country_mode)}
								<span class="availability">
									{if ($product.allow_oosp || $product.quantity > 0)}
										<span class="{if $product.quantity <= 0 && isset($product.allow_oosp) && !$product.allow_oosp} label-danger{elseif $product.quantity <= 0} label-warning{else} label-success{/if}">
											{if $product.quantity <= 0}{if $product.allow_oosp}{if isset($product.available_later) && $product.available_later}{$product.available_later}{else}{l s='In Stock'}{/if}{else}{l s='Out of stock'}{/if}{else}{if isset($product.available_now) && $product.available_now}{$product.available_now}{else}{l s='In Stock'}{/if}{/if}
										</span>
									{elseif (isset($product.quantity_all_versions) && $product.quantity_all_versions > 0)}
										<span class="label-warning">
											{l s='Product available with different options'}
										</span>
									{else}
										<span class="label-danger">
											{l s='Out of stock'}
										</span>
									{/if}
								</span>
							{/if}
						{/if}
					</div>
					{if $page_name != 'index'}
						<div class="functional-buttons clearfix">
							{hook h='displayProductListFunctionalButtons' product=$product}
							{if isset($comparator_max_item) && $comparator_max_item}
								<div class="compare">
									<a class="add_to_compare" href="{$product.link|escape:'html':'UTF-8'}" data-id-product="{$product.id_product}">{l s='Add to Compare'}</a>
								</div>
							{/if}
						</div>
					{/if}
				</div><!-- .product-container> -->
			</li>
		{/foreach}
		</ul>
	{addJsDefL name=min_item}{l s='Please select at least one product' js=1}{/addJsDefL}
	{addJsDefL name=max_item}{l s='You cannot add more than %d product(s) to the product comparison' sprintf=$comparator_max_item js=1}{/addJsDefL}
	{addJsDef comparator_max_item=$comparator_max_item}
	{addJsDef comparedProductsIds=$compared_products}
	{/if}
	<script type="text/javascript">
		$(document).ready(function(){
			$('[id=blocknewproducts],[id=homefeatured]').show();
		});
	</script>
{/if}