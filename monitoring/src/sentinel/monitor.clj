(ns sentinel.monitor
  (:require [clj-http.client :as client]
            [cheshire.core :as json]))

(def mantle-rpc "http://127.0.0.1:8545")
(def guardian-address "0x5FbDB2315678afecb367f032d93F642f64180aa3")
;; Аккаунт #0 из Anvil (обычно этот адрес всегда такой)
(def admin-address "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266")

(defn call-rpc [method params]
  (try
    (let [response (client/post mantle-rpc
                                {:body (json/generate-string
                                        {:jsonrpc "2.0"
                                         :method method
                                         :params params
                                         :id 1})
                                 :content-type :json
                                 :as :json})]
      (get-in response [:body :result]))
    (catch Exception e
      (println "RPC Error:" (.getMessage e)))))

(defn trigger-protection []
  (println "🚀 Sending transaction to SentinelGuardian...")
  ;; 0x84b7b264 - это селектор функции protect() или pause() 
  ;; (зависит от того, как ты назвал её в контракте)
  (let [tx-params [{:from admin-address
                    :to guardian-address
                    :data "0x84b7b264"}] ; Замени на правильный селектор если нужно
        tx-hash (call-rpc "eth_sendTransaction" tx-params)]
    (println "✅ Protection triggered! Tx Hash:" tx-hash)))

(defn get-vault-data [vault-address]
  (println "Agent scanning vault:" vault-address)
  {:assets 1000 :shares 1100}) ; Наша "пылевая" аномалия

(defn -main [& args]
  (println "Sentinel AI Agent started...")
  (let [data (get-vault-data guardian-address)]
    (if (> (:shares data) (:assets data))
      (do
        (println "Alert: Invariant deviation detected!")
        (trigger-protection))
      (println "System healthy."))))
