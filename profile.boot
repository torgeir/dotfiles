;; https://github.com/boot-clj/boot/wiki/Cider-REPL

#_(merge-env!
   :mirrors {#"clojars" {:name "clojars mirror"
                         :url  "https://clojars-mirror.tcrawley.org/repo/"}})

(def v-cider-nrepl "0.13.0")
(def v-refactor-nrepl "2.2.0")

(deftask cider "CIDER profile"
  []
  (require 'boot.repl)
  (swap! @(resolve 'boot.repl/*default-dependencies*)
         concat `[[org.clojure/tools.nrepl "0.2.12"]
                  [cider/cider-nrepl ~v-cider-nrepl]
                  [~'refactor-nrepl ~v-refactor-nrepl]])
  (swap! @(resolve 'boot.repl/*default-middleware*)
         concat '[cider.nrepl/cider-middleware
                  refactor-nrepl.middleware/wrap-refactor])
  identity)
