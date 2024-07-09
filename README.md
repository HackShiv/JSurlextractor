# JSurlextractor
A simple bash script to extract urls from js endpoints.

# Usage
You can add more grepping and filters like grep -E "admin$|api$" at the bottom.
Originally it will look for any beginning with "https://" and spit it out in a decent format. Tweak as you'd like but you will get unwanted stuff and it'll be messy. 
Give it a file full of js urls like https://example.com/.js and it will extract more urls, endpoints and third party services. I use this for recon.

./jsextract.sh -f jsurls.txt -o output.txt
