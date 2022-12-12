export function useDebounce() {
  function debounce(callback, wait) {
    let timeoutId = null;

    return (...args) => {
      window.clearTimeout(timeoutId);
      timeoutId = window.setTimeout(() => {
        callback.apply(null, args);
      }, wait);
    };
  }

  return { debounce };
}
