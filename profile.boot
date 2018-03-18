;; https://github.com/boot-clj/boot/wiki/Cider-REPL

(def v-tools-nrepl "0.2.13")
(def v-cider-nrepl "0.17.0-SNAPSHOT")
(def v-refactor-nrepl "2.4.0-SNAPSHOT")

(deftask cider "CIDER profile"
  []
  (require 'boot.repl)
  (swap! @(resolve 'boot.repl/*default-dependencies*)
         concat `[[org.clojure/tools.nrepl ~v-tools-nrepl]
                  [cider/cider-nrepl ~v-cider-nrepl]
                  [~'refactor-nrepl ~v-refactor-nrepl]])
  (swap! @(resolve 'boot.repl/*default-middleware*)
         concat '[cider.nrepl/cider-middleware
                  refactor-nrepl.middleware/wrap-refactor])
  identity)


(defn get-clipboard []
  (.getSystemClipboard (java.awt.Toolkit/getDefaultToolkit)))


(defn slurp-clipboard []
  (if-let [contents (.getContents (get-clipboard) nil)]
    (.getTransferData contents java.awt.datatransfer.DataFlavor/stringFlavor)))


(defn spit-clipboard [text]
  (.setContents (get-clipboard) (java.awt.datatransfer.StringSelection. text) nil))