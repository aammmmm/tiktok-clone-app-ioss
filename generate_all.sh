#!/bin/bash
set -e

for module in Core DataService Domain FeedWorker Feed Player PlayerWorker Post PostWorker AppNavigations WebViewDetail TikTokCloneApp
do
  echo "Generating $module..."
  xcodegen generate --spec $module/project.yml --project $module
done
