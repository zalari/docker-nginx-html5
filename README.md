## nginx-html5
This is a simple nginx image that enables html-5-mode style urls, by redirecting all request to a single file. This use case is typical for single page apps, that are doing all the routing on the client-side.

Configuration is _inspired_ by https://gist.github.com/cjus/b46a243ba610661a7efb .

## Example usage
This is image is intended to be used as a base image:

```
FROM zalari/nginx-html5

COPY ./app/dist /usr/share/nginx/html/
```

Of course no one can prevent you from using _evil_ bind-mounts for _/usr/share/nginx/html_ which is the document root. 