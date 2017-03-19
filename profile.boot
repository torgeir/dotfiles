;; https://github.com/boot-clj/boot/wiki/Cider-REPL
;; https://github.com/clojure-emacs/cider-nrepl#via-boot

#_(merge-env!
   :mirrors {#"clojars" {:name "clojars mirror"
                         :url  "https://clojars-mirror.tcrawley.org/repo/"}})

(def v-tools-nrepl "0.2.12")
(def v-cider-nrepl "0.15.0-SNAPSHOT")
(def v-refactor-nrepl "2.2.0")

(set-env! :dependencies `[[org.clojure/tools.nrepl ~v-tools-nrepl]
                          [cider/cider-nrepl ~v-cider-nrepl]
                          [~'refactor-nrepl ~v-refactor-nrepl]])

(require '[cider.tasks :refer [add-middleware]])

(task-options! add-middleware {:middleware '[cider.nrepl.middleware.apropos/wrap-apropos
                                             cider.nrepl.middleware.version/wrap-version
                                             refactor-nrepl.middleware/wrap-refactor]})
