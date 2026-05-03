(defproject sentinel "0.1.0-SNAPSHOT"
  :description "Sentinel AI Agent for Mantle Hackathon"
  :dependencies [[org.clojure/clojure "1.11.1"]
                 [clj-http "3.12.3"]
                 [cheshire "5.11.0"]]
  :main ^:skip-aot sentinel.monitor
  :target-path "target/%s"
  :profiles {:uberjar {:aot :all}})
