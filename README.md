# Livebook Notebooks

Collection of Livebook notebooks.

Livebook is also a great way to get your feet wet with Elixir concepts as something slightly above iex, like a powerful language scratch pad.

## Table of Contents

1. [SpiderMan](https://hexdocs.pm/spider_man/elixirjobs.html#content)
   1. [ElixirJobs](spiderman--elixir_jobs.livemd)
   2. [ElixirRadar Jobs](spiderman--elixir_radar_job.livemd)

## SpiderMan

I'm always on the lookout for elixir job posts so when I stumbled on SpiderMan as a crawler and it's livebook example, I was intrigued. The example crawls [https://elixirjobs.net/] to create a CSV of jobs by `link`, `title`, `sub_title`, `date`, `workplace`, and `type`.

[ElixirJobs](spiderman--elixir_jobs.livemd)

I wanted to take the example a few steps further:

1. Crawl the newest 25 pages instead of all 63 at the time of writing this. We don't want to crawl the entire site and ~25 give us about the last year worth of posts.
2. Reorder and change the columns to `date`, `title`, `company`, `location`, `workplace`, `type`, `link`, and `page_number`.
3. Convert the date to `yyyy-mm-dd` format, my ugliest Elixir code so far.
4. Sort the CSV by date descending to see the latest job first.
5. Added sections to make navigation a little easier.
6. In the section marked `Sorting the Results`, I left the section that evaluates to `** (SyntaxError) nofile:5:1: unexpected token: "​" (column 1, code point U+200B)` as U+200B is a zero width space, cleverly hidden in a paste job.

[ElixirRadar Jobs](spiderman--elixir_radar_job.livemd)

This largely builds on the elixir jobs base to crawl [https://elixir-radar.com/jobs] to create a CSV of jobs with some notable exceptions:

1. I hardcoded the page numbers as I'm not sure of the pagination style. `1-5` 
2. There's no date so we sort by page number descending.
3. There's a somewhat larger `description` field that we could've pushed to the end.
