
function openModal(modalId) {
    const modal = document.getElementById(modalId);
    modal.classList.add('mostrar');
    document.body.style.overflow='hidden';
}

function fechaModal(modalId) {
    const modal = document.getElementById(modalId);
    modal.classList.remove('mostrar')
    document.body.style.overflow='auto';

}