#!/usr/bin/env bash
set -euo pipefail
urls=(
  # ----- OLMo v1.5 shards -----
https://olmo-data.org/eval-data/perplexity/v3_small_gptneox20b/c4_en/val/part-0-00000.npy
https://olmo-data.org/eval-data/perplexity/v3_small_gptneox20b/dolma_books/val/part-0-00000.npy
https://olmo-data.org/eval-data/perplexity/v3_small_gptneox20b/dolma_common-crawl/val/part-0-00000.npy
https://olmo-data.org/eval-data/perplexity/v3_small_gptneox20b/dolma_pes2o/val/part-0-00000.npy
https://olmo-data.org/eval-data/perplexity/v3_small_gptneox20b/dolma_reddit/val/part-0-00000.npy
https://olmo-data.org/eval-data/perplexity/v3_small_gptneox20b/dolma_stack/val/part-0-00000.npy
https://olmo-data.org/eval-data/perplexity/v3_small_gptneox20b/dolma_wiki/val/part-0-00000.npy
https://olmo-data.org/eval-data/perplexity/v3_small_gptneox20b/ice/val/part-0-00000.npy
https://olmo-data.org/eval-data/perplexity/v3_small_gptneox20b/m2d2_s2orc/val/part-0-00000.npy
https://olmo-data.org/eval-data/perplexity/v3_small_gptneox20b/pile/val/part-0-00000.npy
https://olmo-data.org/eval-data/perplexity/v3_small_gptneox20b/wikitext_103/val/part-0-00000.npy
https://olmo-data.org/eval-data/perplexity/v2_small_gptneox20b/4chan/val.npy
https://olmo-data.org/eval-data/perplexity/v2_small_gptneox20b/c4_100_domains/val.npy
https://olmo-data.org/eval-data/perplexity/v2_small_gptneox20b/c4_en/val.npy
https://olmo-data.org/eval-data/perplexity/v2_small_gptneox20b/gab/val.npy
https://olmo-data.org/eval-data/perplexity/v2_small_gptneox20b/ice/val.npy
https://olmo-data.org/eval-data/perplexity/v2_small_gptneox20b/m2d2_s2orc/val.npy
https://olmo-data.org/eval-data/perplexity/v2_small_gptneox20b/m2d2_wiki/val.npy
https://olmo-data.org/eval-data/perplexity/v2_small_gptneox20b/manosphere/val.npy
https://olmo-data.org/eval-data/perplexity/v2_small_gptneox20b/mc4_en/val.npy
https://olmo-data.org/eval-data/perplexity/v2_small_gptneox20b/pile/val.npy
https://olmo-data.org/eval-data/perplexity/v2_small_gptneox20b/ptb/val.npy
https://olmo-data.org/eval-data/perplexity/v2_small_gptneox20b/twitterAEE/val.npy
https://olmo-data.org/eval-data/perplexity/v2_small_gptneox20b/wikitext_103/val.npy
)
set -euo pipefail
ROOT_DIR="."
export ROOT_DIR   # hand it to the sub-shells started by xargs

download_one () {
  url="$1"
  rel_path="${url#https://olmo-data.org/eval-data/}"
  dst_path="${ROOT_DIR}/${rel_path}"
  mkdir -p "$(dirname "$dst_path")"
  echo "Fetching $rel_path"
  wget -c --timeout=30 --tries=3 -O "$dst_path" "$url"
  echo "✓ $rel_path done"
}

export -f download_one

printf '%s\n' "${urls[@]}" | xargs -n1 -P 6 bash -c 'download_one "$@"' _
echo "✓ All downloads finished."