export function useTextCase() {
  function uppercase(string) {
    return string.toUpperCase();
  }

  function lowercase(string) {
    return string.toLowerCase();
  }

  function titlecase(string) {
    return string.charAt(0).toUpperCase() + string.toLowerCase().slice(1);
  }

  return { uppercase, lowercase, titlecase };
}
