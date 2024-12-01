const Hooks = {
  RangeSlider: {
    mounted() {
      this.el.addEventListener("input", (e) => {
        // Find and update the number input
        const form = this.el.closest("form");
        const numberInput = form.querySelector('[phx-hook="ProbabilityInput"]');
        if (numberInput) {
          numberInput.value = probability;
        }
      });
    },
  },
  ProbabilityInput: {
    mounted() {
      this.el.addEventListener("input", (e) => {
        // Update both the number input and slider
        const probability = parseFloat(e.target.value);
        this.pushEventTo(this.el, "update_probability", {
          value: probability,
        });
        // Find and update the range slider
        const form = this.el.closest("form");
        const rangeSlider = form.querySelector('[phx-hook="RangeSlider"]');
        if (rangeSlider) {
          rangeSlider.value = probability;
        }
      });
    },
  },
};

export default Hooks;
