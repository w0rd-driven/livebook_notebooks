# Livebook Notebooks

Collection of Livebook notebooks.

Livebook is also a great way to get your feet wet with Elixir concepts, like a powerful language scratchpad.

### Table of Contents

* [Usage](#usage)
* [Job Board Crawling by SpiderMan](#job-board-crawling-by-spiderman)
  * [Elixir Jobs](#elixir-jobs)
  * [ElixirRadar Job Board](#elixirradar-job-board)
  * [Elixir Companies](#elixir-companies)
* [Job Search](#job-search)
  * [Job Description to Markdown](#job-description-to-markdown)
  * [Job Application Fields to Markdown](#job-application-fields-to-markdown)
* [Miscellaneous](#miscellaneous)
  * [Scratchpad](#scratchpad)
  * [Oddities and Awkward Things](#oddities-and-awkward-things)

## Usage

1. install a compatible Elixir and Erlang version. You may wish to use [asdf](https://asdf-vm.com/guide/getting-started.html#_1-install-dependencies).
   1. We have included a `.tool-versions` file to support local Elixir versions
2. Install [Livebook via escript](https://github.com/livebook-dev/livebook#escript) (preferred) or via the [Desktop app](https://github.com/livebook-dev/livebook/releases) .
3. From this project folder run `livebook server index.livemd`. This opens the main navigation page where you can access all the other Livebook examples.

## Job Board Crawling by SpiderMan

I'm always on the lookout for elixir job posts so when I stumbled on SpiderMan as a crawler and it's livebook example, I was intrigued. The example crawls [https://elixirjobs.net/] to create a CSV of jobs by `link`, `title`, `sub_title`, `date`, `workplace`, and `type`.

### Elixir Jobs

[ElixirJobs](spiderman--elixir_jobs.livemd)

[![Run in Livebook](https://livebook.dev/badge/v1/blue.svg)](https://livebook.dev/run?url=https%3A%2F%2Fgithub.com%2Fw0rd-driven%2Flivebook_notebooks%2Fblob%2Fmain%2Fspiderman--elixir_jobs.livemd)

I wanted to take the example a few steps further:

1. Crawl the newest 25 pages instead of all 63 at the time of writing this. We don't want to crawl the entire site and ~25 give us about the last year worth of posts.
2. Reorder and change the columns to `date`, `title`, `company`, `location`, `workplace`, `type`, `link`, and `page_number`.
3. Convert the date to `yyyy-mm-dd` format, my ugliest Elixir code so far.
4. Sort the CSV by date descending to see the latest job first.
5. Added sections to make navigation a little easier.
6. In the section marked `Sorting the Results`, I left the section that evaluates to `** (SyntaxError) nofile:5:1: unexpected token: "​" (column 1, code point U+200B)` as U+200B is a zero width space, cleverly hidden in a paste job.

### ElixirRadar Job Board

[ElixirRadar Job Board](spiderman--elixir_radar_job.livemd)

[![Run in Livebook](https://livebook.dev/badge/v1/blue.svg)](https://livebook.dev/run?url=https%3A%2F%2Fgithub.com%2Fw0rd-driven%2Flivebook_notebooks%2Fblob%2Fmain%2Fspiderman--elixir_radar_jobs.livemd)

This largely builds on the elixir jobs base to crawl [https://elixir-radar.com/jobs] to create a CSV of jobs with some notable exceptions:

1. I hardcoded the page numbers as I'm not sure of the pagination style. `1-6` seems to follow a pattern so far but we can address this later.
2. There's no date so we sort by page number descending.
3. There's a somewhat larger `description` field that we could've pushed to the end.

### Elixir Companies

[Elixir Companies](spiderman--elixir_companies.livemd)

[![Run in Livebook](https://livebook.dev/badge/v1/blue.svg)](https://livebook.dev/run?url=https%3A%2F%2Fgithub.com%2Fw0rd-driven%2Flivebook_notebooks%2Fblob%2Fmain%2Fspiderman--elixir_companies.livemd)

This builds on the elixir radar jobs base to crawl [https://elixir-companies.com/en/companies] to create a CSV of companies.

1. Due to the way the DOM is structured, fields aren't in independent elements. There's text with `<br>` tags that translate to `\n` when parsing.
2. This involved pulling the last 1 or 2 elements from the end of the list as the first element was always one bit of information with the remaining portions covering one or more fields.
3. The site feels so different to parse that it almost felt like starting from scratch.
4. While Elixir Companies utilizes infinite scroll techniques in the browser to fetch page requests, it follows what I presume is a standard `page=number` query string format that is identical between the 3 sites. To me, these notebooks showcase how quickly I got up and running with `spider_man` over other web crawling techniques. I'm a huge fan now.

## Job Search

### Job Description to Markdown

[Job Description to Markdown](req--job_description.livemd)

[![Run in Livebook](https://livebook.dev/badge/v1/blue.svg)](https://livebook.dev/run?url=https%3A%2F%2Fgithub.com%2Fw0rd-driven%2Flivebook_notebooks%2Fblob%2Fmain%2Freq--job_description.livemd)

Using the excellent `req` library, we want to get the HTML of the job post url and convert the contents to markdown.

### Job Application Fields to Markdown

[Job Application Fields to Markdown](req--job_fields.livemd)

[![Run in Livebook](https://livebook.dev/badge/v1/blue.svg)](https://livebook.dev/run?url=https%3A%2F%2Fgithub.com%2Fw0rd-driven%2Flivebook_notebooks%2Fblob%2Fmain%2Freq--job_fields.livemd)

Using the excellent `req` library, we want to get the HTML of the job post application url and convert all form fields to markdown.

## Miscellaneous

### Scratchpad

[Scratchpad](scratchpad.livemd)

[![Run in Livebook](https://livebook.dev/badge/v1/blue.svg)](https://livebook.dev/run?url=https%3A%2F%2Fgithub.com%2Fw0rd-driven%2Flivebook_notebooks%2Fblob%2Fmain%2Fscratchpad.livemd)

A scratch pad for various code doodles.

### Oddities and Awkward Things

[Oddities and Awkward Things](oddities.livemd)

[![Run in Livebook](https://livebook.dev/badge/v1/blue.svg)](https://livebook.dev/run?url=https%3A%2F%2Fgithub.com%2Fw0rd-driven%2Flivebook_notebooks%2Fblob%2Fmain%2Foddities.livemd)

Odd behavior and awkward things I've run into in my experiences with Livebook. I'm by far no Elixir expert though I am getting more up to speed all the time.
