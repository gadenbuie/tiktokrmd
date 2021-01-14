
<!-- README.md is generated from README.Rmd. Please edit that file -->

# tiktokrmd

<!-- badges: start -->
<!-- badges: end -->

Embed TikTok videos in R Markdown things!

## Installation

You can install the released version of tictokrmd from GitHub:

``` r
remotes::install_github("gadenbuie/tiktokrmd")
```

## How to TikTok in R Markdown

### Example

``` r
library(tiktokrmd)

tt_url <- "https://www.tiktok.com/@aquickspoonful/video/6890681375431691526"
tt <- tiktok_embed(tt_url)

## # in R Markdown, just print the object to embed it
## tt

# Or write a plain markdown version
tiktok_md(tt)
#> [1] "![[#cake #cakes #dontmixit #cakelover #cakelovers #dumpcake #food #tiktokfood #foodtiktok #easyrecipe #easyrecipes #peach #peaches #cinnamon #fyp](https://www.tiktok.com/@aquickspoonful/video/6890681375431691526) by [Sophia Wasu](https://www.tiktok.com/@aquickspoonful)](https://p16-sign-va.tiktokcdn.com/obj/tos-maliva-p-0068/00189a8b703343bd817a3ccaec240f71?x-expires=1610654400&x-signature=ExJZaEMAgxhyXydfgsqgZqU%2B8y8%3D)"

# Or as HTML without the full TikTok embedded player shenanigans
tiktok_html(tt, include_player = FALSE)
```

<!--html_preserve-->
<blockquote class="tiktok-embed" cite="https://www.tiktok.com/@aquickspoonful/video/6890681375431691526" data-video-id="6890681375431691526" style="max-width: 605px;min-width: 325px;">
<section>
<a target="_blank" title="@aquickspoonful" href="https://www.tiktok.com/@aquickspoonful">@aquickspoonful</a>
<p>
<a title="cake" target="_blank" href="https://www.tiktok.com/tag/cake">\#cake</a>
<a title="cakes" target="_blank" href="https://www.tiktok.com/tag/cakes">\#cakes</a>
<a title="dontmixit" target="_blank" href="https://www.tiktok.com/tag/dontmixit">\#dontmixit</a>
<a title="cakelover" target="_blank" href="https://www.tiktok.com/tag/cakelover">\#cakelover</a>
<a title="cakelovers" target="_blank" href="https://www.tiktok.com/tag/cakelovers">\#cakelovers</a>
<a title="dumpcake" target="_blank" href="https://www.tiktok.com/tag/dumpcake">\#dumpcake</a>
<a title="food" target="_blank" href="https://www.tiktok.com/tag/food">\#food</a>
<a title="tiktokfood" target="_blank" href="https://www.tiktok.com/tag/tiktokfood">\#tiktokfood</a>
<a title="foodtiktok" target="_blank" href="https://www.tiktok.com/tag/foodtiktok">\#foodtiktok</a>
<a title="easyrecipe" target="_blank" href="https://www.tiktok.com/tag/easyrecipe">\#easyrecipe</a>
<a title="easyrecipes" target="_blank" href="https://www.tiktok.com/tag/easyrecipes">\#easyrecipes</a>
<a title="peach" target="_blank" href="https://www.tiktok.com/tag/peach">\#peach</a>
<a title="peaches" target="_blank" href="https://www.tiktok.com/tag/peaches">\#peaches</a>
<a title="cinnamon" target="_blank" href="https://www.tiktok.com/tag/cinnamon">\#cinnamon</a>
<a title="fyp" target="_blank" href="https://www.tiktok.com/tag/fyp">\#fyp</a>
</p>
<a target="_blank" title="♬ original sound - Sophia Wasu" href="https://www.tiktok.com/music/original-sound-6890681399725099782">♬
original sound - Sophia Wasu</a>
</section>
</blockquote>

<!--/html_preserve-->

### ⚠️ Previewing Locally ⚠️

TikTok’s embedding script only works when the page with the embedded
video is being served. For some reason, it doesn’t seem to work when
viewing a local file.

The easiest way around this is to use the **Infinite Moon Reader** addin
(or `inf_mr()`) from [xaringan](https://github.com/yihui/xaringan) to
render your R Markdown document. If you’re working on a blog post,
`blogdown::serve_site()` probably works fine. In all cases, you’ll still
need to preview the rendered page in an external browser, like FireFox,
Chrome, or Safari.

<h3>Description</h3>

<p>Embeds a TikTok video in an R Markdown document. In rich HTML formats, the
full TikTok video player is used. Note that the video will likely fail to
appear when previewing locally, unless you serve the document with something
like <code>servr::httd()</code>. In limited HTML formats or non-HTML formats, the
TikTok content is rendered into an image with a link in markdown. Use the
helper functions listed below if you want to control the output.
</p>


<h3>Usage</h3>

<pre>
tiktok_embed(url)

tiktok_md(tt, ...)

tiktok_html(tt, include_player = TRUE, ...)
</pre>


<h3>Arguments</h3>

<table summary="R argblock">
<tr valign="top"><td><code>url</code></td>
<td>
<p>A TikTok video URL</p>
</td></tr>
<tr valign="top"><td><code>tt</code></td>
<td>
<p>A TikTok video URL or <code>tiktok_embed()</code> result</p>
</td></tr>
<tr valign="top"><td><code>...</code></td>
<td>
<p>Ignored</p>
</td></tr>
<tr valign="top"><td><code>include_player</code></td>
<td>
<p>Include the TikTok embed JavaScript that builds the
rich HTML player (and probably adds a considerable amount of user tracking)</p>
</td></tr>
</table>


<h3>Value</h3>

<p><code>tiktok_embed</code>: Returns the TikTok oEmbed API response. The returned
object has a <code>knit_print()</code> method for automatic embedding in R Markdown.
</p>
<p><code>tiktok_md</code>: A Markdown representation of the TikTok video, in the
format <code style="white-space: pre;">![&lt;title&gt; by &lt;author&gt;](&lt;thumbnail_image_url&gt;)</code>
</p>
<p><code>tiktok_html</code>: The TikTok embedding HTML as an <code>htmltools::tagList</code>
</p>


<h3>Functions</h3>


<ul>
<li> <p><code>tiktok_embed</code>: Embed a TikTok video in R Markdown, or return the oEmbed
API response.
</p>
</li>
<li> <p><code>tiktok_md</code>: Format the TikTok video url or <code>tiktok_embed()</code> result as
markdown
</p>
</li>
<li> <p><code>tiktok_html</code>: Format the TikTok video url or <code>tiktok_embed()</code> result as
HTML
</p>
</li></ul>


<h3>References</h3>

<p><a href="https://developers.tiktok.com/doc/Embed">https://developers.tiktok.com/doc/Embed</a>
</p>
