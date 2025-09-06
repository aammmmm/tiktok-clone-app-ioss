#!/bin/bash
set -e

for module in Core DataService FeedWorker Feed Player PlayerWorker Post PostWorker AppNavigations WebViewDetail TikTokCloneApp
do
  echo "Generating $module..."
  xcodegen generate --spec $module/project.yml --project $module
done
