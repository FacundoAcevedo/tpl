# builder
FROM python:3-alpine AS zipper

RUN apk update && apk add make

COPY ./ /app
RUN make -C /app dist/tpl

# final image
FROM python:3-alpine

COPY --from=zipper /app/dist/tpl /usr/bin/tpl

ENTRYPOINT ["tpl"]

CMD ["--environment", "-","-"]
