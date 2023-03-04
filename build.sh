#!/usr/bin/env bash
# vim: ai ts=4 sts=4 et sw=4
#
#     This file is part of hleroy/backup-s3. backup-s3 periodically backs up
#     a database (postgres or mysql) and/or data folder(s) to Amazon S3.
#     Copyright © 2012-2023 Hervé Le Roy
#
#     This program is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.
#
#     This program is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.
#
#     You should have received a copy of the GNU General Public License
#     along with this program.  If not, see <https://www.gnu.org/licenses/>.

VERSION="v3.0"

echo "Building hleroy/backup-s3 ${VERSION}"

docker build -t hleroy/backup-s3:${VERSION}-pg15 -t hleroy/backup-s3:latest  --build-arg POSTGRES_VERSION=15 .
docker build -t hleroy/backup-s3:${VERSION}-pg14 --build-arg POSTGRES_VERSION=14 .
docker build -t hleroy/backup-s3:${VERSION}-pg13 --build-arg POSTGRES_VERSION=13 .

docker images hleroy/backup-s3