`%||%` <- function(x, y) if (is.null(x)) y else x

#' Embed a TikTok Video
#'
#' Embeds a TikTok video in an R Markdown document. In rich HTML formats, the
#' full TikTok video player is used. Note that the video will likely fail to
#' appear when previewing locally, unless you serve the document with something
#' like `servr::httd()`. In limited HTML formats or non-HTML formats, the
#' TikTok content is rendered into an image with a link in markdown. Use the
#' helper functions listed below if you want to control the output.
#'
#' @examples
#' tt_url <- "https://www.tiktok.com/@aquickspoonful/video/6890681375431691526"
#' tt <- tiktok_embed(tt_url)
#'
#' # in R Markdown, just print the object to embed it
#' tt
#'
#' # Or write a plain markdown version
#' tiktok_md(tt)
#'
#' # Or as HTML without the full TikTok embedded player shenanigans
#' tiktok_html(tt, include_player = FALSE)
#'
#' @name tiktok
NULL

#' @describeIn tiktok Embed a TikTok video in R Markdown, or return the oEmbed
#'   API response.
#' @references <https://developers.tiktok.com/doc/Embed>
#' @return `tiktok_embed`: Returns the TikTok oEmbed API response. The returned
#'   object has a `knit_print()` method for automatic embedding in R Markdown.
#' @param url A TikTok video URL
#' @export
tiktok_embed <- function(url) {
  tt_oembed_url <- sprintf(
    "https://www.tiktok.com/oembed?url=%s",
    url
  )
  res <- httr::GET(tt_oembed_url)
  httr::stop_for_status(res, "Get embedding information from tiktok")
  tt <- httr::content(res)

  expected_items <- c("title", "author_name", "author_url", "html")
  if (!all(expected_items %in% names(tt))) {
    warning(
      "Received unusual response from TikTok oEmbed API ",
      "for this video:", url,
      immediate. = TRUE
    )
  }

  tt$tiktok_url <- url
  structure(tt, class = c("tiktok_embed", "list"))
}

#' @describeIn tiktok Format the TikTok video url or `tiktok_embed()` result as
#'   markdown
#' @param tt A TikTok video URL or `tiktok_embed()` result
#' @param ... Ignored
#' @return `tiktok_md`: A Markdown representation of the TikTok video, in the
#'   format `![<title> by <author>](<thumbnail_image_url>)`
#' @export
tiktok_md <- function(tt, ...) UseMethod("tiktok_md", tt)

#' @export
tiktok_md.character <- function(tt, ...) {
  tiktok_md(tiktok_embed(tt), ...)
}

#' @export
tiktok_md.tiktok_embed <- function(tt, ...) {
  author_md <- sprintf("[%s](%s)", tt$author_name, tt$author_url)
  title <- if (identical(tt$title, "")) "A TikTok" else tt$title

  caption <- sprintf(
    "[%s](%s) by %s",
    title,
    tt$tiktok_url,
    author_md
  )
  if (is.null(tt$thumbnail_url) || identical(tt$thumbnail_url, "")) {
    return(caption)
  }
  sprintf("![%s](%s)", caption, tt$thumbnail_url)
}

#' @describeIn tiktok Format the TikTok video url or `tiktok_embed()` result as
#'   HTML
#' @param include_player Include the TikTok embed JavaScript that builds the
#'   rich HTML player (and probably adds a considerable amount of user tracking)
#' @return `tiktok_html`: The TikTok embedding HTML as an `htmltools::tagList`
#' @export
tiktok_html <- function(tt, include_player = TRUE, ...) UseMethod("tiktok_html", tt)

#' @export
tiktok_html.character <- function(tt, include_player = TRUE, ...) {
  tiktok_html(tiktok_embed(tt), include_player = include_player, ...)
}

#' @export
tiktok_html.tiktok_embed <- function(tt, include_player = TRUE, ...) {
  if (!"html" %in% names(tt)) return(NULL)
  tt <- sub('<script async src="https://www.tiktok.com/embed.js"></script>', "", tt$html)
  tt <- htmltools::HTML(tt)
  if (!isTRUE(include_player)) {
    tt
  } else {
    htmltools::tagList(tt, tiktok_dependency())
  }
}

tiktok_dependency <- function() {
  htmltools::singleton(
    htmltools::tagList(
      htmltools::tags$script(
        async = NA,
        `data-external` = "1",
        src = "https://www.tiktok.com/embed.js"
      ),
      htmltools::tags$style(
        "blockquote.tiktok-embed {border:unset;padding:unset;}"
      )
    )
  )
}

#' @importFrom knitr knit_print
#' @export
knit_print.tiktok_embed <- function(x, ...) {
  if (knitr::is_html_output(excludes = "gfm")) {
    htmltools::knit_print.shiny.tag.list(tiktok_html(x))
  } else {
    knitr::asis_output(tiktok_md(x), cacheable = TRUE)
  }
}
