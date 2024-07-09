# JSurlextractor
A simple bash script to extract urls and endpoints within js files

# Usage
You can add more grepping and filters like grep -E "admin$|api$" at the bottom.
Originally it will look for any beginning with "https://" and spit it out in a decent format. Tweak as you'd like but you will get unwanted stuff and it'll be messy.

./jsextract.sh -f jsurls.txt -o output.txt
