document.addEventListener('DOMContentLoaded', () => {
  setUpTravelerOptionControl();
});

const sections = (() => {
  return {
    travelerOption: function() {
      return document.getElementById('journey_traveler_option');
    },

    travelerSelect: function() {
      return document.getElementsByClassName("traveler_select_section")[0];
    },

    newTraveler: function() {
      return document.getElementsByClassName("new_traveler_section")[0];
    }
  }
})();

const travelerSelectionVisible = (boolean) => `traveler_select_section${boolean ? "" : " hidden"}`;
const newTravelerSectionVisible = (boolean) => `new_traveler_section${boolean ? "" : " hidden"}`;

const sectionClassNames = {
  "selected traveler": [travelerSelectionVisible(true), newTravelerSectionVisible(false)],
  "random traveler": [travelerSelectionVisible(false), newTravelerSectionVisible(false)],
  "new traveler": [travelerSelectionVisible(false), newTravelerSectionVisible(true)]
};

const switchVisibleSections = (value) => {
  sections.travelerSelect().className = sectionClassNames[value][0];
  sections.newTraveler().className = sectionClassNames[value][1];
}

const setUpTravelerOptionControl = () => {
  const initialTravelerOption = sections.travelerOption().value;
  switchVisibleSections(initialTravelerOption);

  sections.travelerOption().addEventListener('change', (event) => {
    const selectedTravelerOption = event.target.value;
    switchVisibleSections(selectedTravelerOption);
  })
};